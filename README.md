# Seven Kingdoms: Ancient Adversaries (HD support)

HD resolution patch and UI fixes for **7kaa (Seven Kingdoms: Ancient Adversaries)** based on the latest official source.

## 📌 Overview

This repository is a modified version of the official **7kaa v2.15.8** (latest commit: 2026-04-04), enhanced with modern HD resolution support and several UI improvements.

It builds upon prior HD work and refines it further with additional fixes and usability improvements.

## 📦 Windows Install (Pre-built Release)

Download the latest `Winx86_64` release from [https://github.com/kresimirv/7kaa_HD/releases](https://github.com/kresimirv/7kaa_HD/releases) and extract it.

Edit `config.txt` in the game directory to set your desired resolution (see [Configuration](#%EF%B8%8F-configuration)).

## 📦 Linux Install (Pre-built Release)

Download the latest `7kaaHD_Linux_x86_64_*.AppImage` from [Releases](https://github.com/kresimirv/7kaa_HD/releases).

Make executable and run:
```bash
chmod +x 7kaaHD_Linux_x86_64_*.AppImage
./7kaaHD_Linux_x86_64_*.AppImage
```

No dependencies needed — everything is bundled inside the AppImage.

## Screenshots

![Main Menu](screenshots/main_menu.png)
![Gameplay](screenshots/gameplay.png)

## ✨ Features

### 🖥️ Supported Resolutions

The engine now supports **custom resolutions up to 3180×2160**.

Example supported aspect ratios:

#### 16:9

* 2560×1440
* 1920×1080
* 1280×720

#### 5:4

* 1280×1024
  
#### 4:3

* 1600×1200
* 1024×768
* 800×600

### 🛠️ Fixes & Improvements

* **Main Menu → Training**

  * Fixed text overlapping issues
  * Fixed scrollbar redraw when switching menu options with a single click

* **Load/Save Screen**

  * Properly centered on screen across all supported resolutions

* **Configuration**

  * Resolution setting is now configurable via `config.txt`

## ⚙️ Configuration

The game resolution is controlled through the `config.txt` file.

### 📍 Config File Locations

**Linux**

```
/home/<your_user>/.local/share/7kfans.com/7kaa/
```

**Windows**

```
%appdata%/7kfans.com/7kaa/
```

### 🧾 Example `config.txt`

```
# custom game resolution
vga_resolution_width=1280
vga_resolution_height=1024
```
---

## 📥 Cloning the Repository

```bash
git clone https://github.com/kresimirv/7kaa_HD.git
```

## 🪟 Windows Build Instructions

### Prerequisites

- [MSYS2](https://www.msys2.org/) installed to default location (`C:\msys64`)
- [GIT](https://git-scm.com/) installed

### Setup

From Start menu, find and run **MSYS2 MINGW64**.

Update MSYS2 and install build tools and dependencies:
```bash
pacman -Syu
```

Close the terminal, reopen **MSYS2 MINGW64**, then:
```bash
pacman -Su mingw-w64-x86_64-gcc mingw-w64-x86_64-SDL2 \
  mingw-w64-x86_64-openal mingw-w64-x86_64-curl \
  mingw-w64-x86_64-enet autoconf automake make libtool git
```

### Clone & Build

In **MSYS2 MINGW64**:
```bash
cd /home/
git clone https://github.com/kresimirv/7kaa_HD.git
cd 7kaa_HD/
./build-windows-msys2.sh
```

### Package for Distribution

Create a folder `7kaaHD` and copy into it:
- data & music folders (from original game)
- `7kaa.exe` (from `C:\msys64\home\7kaa_HD\`)
- Required DLLs (from `C:\msys64\mingw64\bin\`)

## 🐧 Linux Build Instructions

### From Source

#### Required Build Tools

* gcc / g++
* make
* autoconf
* automake

#### Build

```bash
git clean -dxf
autoreconf -vif
./configure && make -j$(nproc)
```

### AppImage

Build a portable self-contained AppImage (no dependencies needed at runtime):

**Debian/Ubuntu-based:**
```bash
sudo apt install build-essential autoconf automake libtool \
  libsdl2-dev libopenal-dev libenet-dev libcurl4-openssl-dev \
  patchelf squashfs-tools
```

**Arch-based:**
```bash
sudo pacman -S base-devel autoconf automake libtool sdl2 \
  openal enet curl patchelf squashfs-tools
```

Then run:
```bash
./build-linux-appimage.sh
```

## 🎵 Game Music & Manual

Original game music, manuals, and additional resources are available from the official Seven Kingdoms fan site:

- Music packs
- Game manuals
- Additional downloads and resources

https://7kfans.com/download/

## 🔧 Base Project

This project is based on:

* Official 7kaa v2.15.8 source
* Community HD improvements from earlier work (https://github.com/starportx/7kaa)

## 🚀 Purpose

The goal of this repository is to modernize the original game experience by:

* Enabling higher resolutions
* Fixing UI issues that appear at larger screen sizes
* Preserving original gameplay and compatibility
* Keeping engine modifications lightweight and maintainable

## 📷 Notes

This is a lightweight enhancement project — no gameplay changes, only visual and usability improvements.
