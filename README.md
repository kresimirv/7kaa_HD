# Seven Kingdoms: Ancient Adversaries (HD support)

HD resolution patch and UI fixes for **7kaa (Seven Kingdoms: Ancient Adversaries)** based on the latest official source.

## 📌 Overview

This repository is a modified version of the official **7kaa v2.15.8** (latest commit: 2026-04-04), enhanced with modern HD resolution support and several UI improvements.

It builds upon prior HD work and refines it further with additional fixes and usability improvements.

## Screenshots

![Main Menu](screenshots/main_menu.png)
![Gameplay](screenshots/gameplay.png)

## ✨ Features

### 🖥️ Supported Resolutions

* 800×600
* 1024×768
* 1280×1024
* 1920×1080

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
# game resolution - 0:800x600 1:1024x768 2:1280x1024 3:1920x1080
resolution=1
```

## 🔧 Base Project

This project is based on:

* Official 7kaa v2.15.8 source
* Community HD improvements from earlier work (https://github.com/starportx/7kaa)

## 🚀 Purpose

The goal of this repository is to modernize the original game experience by:

* Enabling higher resolutions
* Fixing UI issues that appear at larger screen sizes
* Keeping changes minimal and compatible with the original codebase

## 📷 Notes

This is a lightweight enhancement project — no gameplay changes, only visual and usability improvements.
