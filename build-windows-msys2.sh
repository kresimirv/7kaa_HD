#!/bin/bash
set -e

SRC=src
INC=include

CXXFLAGS="-std=c++11 -O2 -fsigned-char -mfpmath=387 -ffloat-store -fexcess-precision=fast -include $INC/config.h"
CPPFLAGS="-I$INC -I/mingw64/include -I/mingw64/include/SDL2"
LIBS="-L/mingw64/lib -lmingw32 -lSDL2main -lSDL2 -lopenal -lenet -lcurl -lole32 -lwinmm -lws2_32 -static-libstdc++ -static-libgcc -mwindows"

# Generate config.h
cat > $INC/config.h << 'EOF'
#define USE_WINDOWS 1
#define USE_SDL 1
#define USE_OPENAL 1
#define USE_ENET 1
#define HAVE_LIBCURL 1
#define NO_MEM_CLASS 1
#define HAVE_KNOWN_BUILD 1
#define OPENAL_AL_H <AL/al.h>
#define OPENAL_ALC_H <AL/alc.h>
#define REGISTER register
EOF

# Install locale files (copy compiled .gmo from po/ to locale/<lang>/LC_MESSAGES/7kaa.mo)
echo "Installing locale files..."
for gmo in po/*.gmo; do
  lang=$(basename "$gmo" .gmo)
  mkdir -p "locale/$lang/LC_MESSAGES"
  cp "$gmo" "locale/$lang/LC_MESSAGES/7kaa.mo"
done

# Build sub-libraries
echo "Building sub-libraries..."
g++ $CXXFLAGS $CPPFLAGS -c $SRC/openal/openal_audio.cpp -o $SRC/openal/openal_audio.o
g++ $CXXFLAGS $CPPFLAGS -c $SRC/openal/wav_stream.cpp -o $SRC/openal/wav_stream.o
ar rcs $SRC/openal/libaudio_openal.a $SRC/openal/openal_audio.o $SRC/openal/wav_stream.o

g++ $CXXFLAGS $CPPFLAGS -c $SRC/enet/multiplayer.cpp -o $SRC/enet/multiplayer.o
ar rcs $SRC/enet/libmultiplayer.a $SRC/enet/multiplayer.o

for f in $SRC/imgfun/generic/*.cpp; do
  echo "  imgfun: $(basename $f)"
  g++ $CXXFLAGS $CPPFLAGS -c "$f" -o "${f%.cpp}.o"
done
ar rcs $SRC/imgfun/generic/libimgfun_generic.a $SRC/imgfun/generic/*.o

g++ $CXXFLAGS $CPPFLAGS -c $SRC/curl/WebService.cpp -o $SRC/curl/WebService.o
ar rcs $SRC/curl/libWebService.a $SRC/curl/WebService.o

# Build all main sources
echo "Building main sources..."
for f in $SRC/*.cpp; do
  echo "  $(basename $f)"
  g++ $CXXFLAGS $CPPFLAGS -c "$f" -o "${f%.cpp}.o"
done

# Windows resource
echo "Building resource..."
windres -I$INC -i $SRC/ico.rc -o $SRC/ico.o

# Link
echo "Linking..."
g++ $SRC/*.o $SRC/openal/libaudio_openal.a $SRC/enet/libmultiplayer.a \
    $SRC/imgfun/generic/libimgfun_generic.a $SRC/curl/libWebService.a \
    $LIBS -o 7kaa.exe

echo "Done: 7kaa.exe"
