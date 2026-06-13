#!/bin/bash
# Build 7kaa as a portable Linux AppImage
set -e

APP="7kaa"
ARCH="x86_64"
APPDIR="AppDir"
OUTPUT="${OUTPUT:-7kaaHD_Linux_${ARCH}_v2_15_8_04_2026.AppImage}"

# Generate configure if not present
if [ ! -f configure ]; then
    echo "==> Generating configure..."
    autoreconf -vif
fi

# Build the game
echo "==> Building $APP..."
./configure --disable-fhs
make -j$(nproc)

# Create AppDir structure
echo "==> Creating AppDir..."
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/bin"
mkdir -p "$APPDIR/usr/share/$APP"
mkdir -p "$APPDIR/usr/share/applications"
mkdir -p "$APPDIR/usr/share/icons/hicolor/256x256/apps"
mkdir -p "$APPDIR/usr/lib"

# Copy binary
cp src/$APP "$APPDIR/usr/bin/"

# Copy data
cp -r data/* "$APPDIR/usr/share/$APP/"

# Copy desktop file and icon
cp packaging/linux/seven-kingdoms.desktop "$APPDIR/usr/share/applications/"
cp packaging/linux/seven-kingdoms.png "$APPDIR/usr/share/icons/hicolor/256x256/apps/"

# Symlinks for AppImage discovery
ln -sf "usr/share/applications/seven-kingdoms.desktop" "$APPDIR/"
ln -sf "usr/share/icons/hicolor/256x256/apps/seven-kingdoms.png" "$APPDIR/"
ln -sf "usr/share/icons/hicolor/256x256/apps/seven-kingdoms.png" "$APPDIR/.DirIcon"

# Write AppRun script
cat > "$APPDIR/AppRun" << 'APPRUN'
#!/bin/bash
HERE="$(dirname "$(readlink -f "$0")")"
export LD_LIBRARY_PATH="$HERE/usr/lib:$LD_LIBRARY_PATH"
export SKDATA="$HERE/usr/share/7kaa"
exec "$HERE/usr/bin/7kaa" "$@"
APPRUN
chmod +x "$APPDIR/AppRun"

# Bundle shared libraries
echo "==> Bundling libraries..."
copy_libs() {
    local BIN="$1"
    for lib in $(ldd "$BIN" 2>/dev/null | grep "=> /" | awk '{print $3}'); do
        base=$(basename "$lib")
        if [ ! -f "$APPDIR/usr/lib/$base" ]; then
            cp -L "$lib" "$APPDIR/usr/lib/"
            copy_libs "$lib"
        fi
    done
}
copy_libs "$APPDIR/usr/bin/$APP"

# Remove libs that cause conflicts (libc, libm, libstdc++ etc.)
for lib in libc.so libm.so libdl.so libpthread.so librt.so libutil.so \
           libstdc++.so libgcc_s.so; do
    rm -f "$APPDIR/usr/lib/$lib"*
done

# Set rpath so libs are found
patchelf --set-rpath '$ORIGIN/../lib' "$APPDIR/usr/bin/$APP"

# Build AppImage
echo "==> Creating squashfs..."
mksquashfs "$APPDIR" "$APP.squashfs" -root-owned -noappend -quiet

echo "==> Downloading AppImage runtime..."
RUNTIME="runtime-$ARCH"
wget -qnc "https://github.com/AppImage/AppImageKit/releases/download/continuous/$RUNTIME"
chmod +x "$RUNTIME"

echo "==> Assembling AppImage..."
cat "$RUNTIME" "$APP.squashfs" > "$OUTPUT"
chmod +x "$OUTPUT"

# Clean up
rm -f "$APP.squashfs" "$RUNTIME"

echo "==> Done!"
ls -lh "$OUTPUT"
