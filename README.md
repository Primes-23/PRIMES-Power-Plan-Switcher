# 🔴 PRIMES Power Plan Switcher

A lightweight, zero-bloat Windows context-menu utility designed to let you instantly switch power plans straight from your desktop. 

Perfect for users who want to jump between high-performance gaming modes and power-saving modes without digging through the Windows Control Panel. Built entirely in AutoHotkey, it requires no background processes, making it an ideal fit for optimized or debloated Windows builds.

## ✨ Features

* **Dynamic Detection:** Automatically scans your PC and lists all available power plans (both default Windows plans and custom ones).
* **Custom Crimson GUI:** Features a sleek, custom dark-red interface with dynamic radio buttons (`●` / `○`) indicating your currently active plan.
* **Context Menu Integration:** Adds a clean "Power Plan Switcher" option directly to your Windows desktop right-click menu.
* **Zero Background Footprint:** The script only runs exactly when you click it and closes immediately after, consuming zero idle CPU or RAM.
* **Open Source:** Fully transparent AutoHotkey (`.ahk`) source code provided.

## 🚀 Quick Install (Recommended)

1. Go to the [Releases page](../../releases/latest) and download the latest **`PowerPlanSwitcher.installer.exe`**.
2. Right-click the file and select **Run as administrator**.
3. Choose your preferred installation directory.
4. Right-click anywhere on your desktop background and select **Power Plan Switcher** to use the tool!

> **Note on Antivirus Flags:** Because this installer extracts files and modifies the registry to create the context menu item, heuristic AI scanners may flag it as a false positive. It is 100% safe. You can view the full security analysis in the [Release Notes](../../releases/latest).

## 🛠️ Manual Installation (For Advanced Users)

If you prefer not to use the automated installer, you can set it up manually using the source files:
1. Download `PowerPlanSwitcher.ahk` and compile it using Ahk2Exe (use `PRIMES LOGO.ico` for the icon).
2. Place the compiled `.exe` in a permanent folder on your drive.
3. Open `registry setting.reg` in a text editor (like Notepad) and change the file path to match exactly where you saved your `.exe`.
4. Save the `.reg` file, double-click it, and accept the prompt to merge it into your Windows Registry.

*To completely remove the context menu hook at any time, simply run the included `registry setting remover.reg` file.*

## 📜 License

This project is licensed under the **MIT License**. You are free to use, modify, and distribute this software.
