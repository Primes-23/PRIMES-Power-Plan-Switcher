# PRIMES Power Plan Switcher

Fast Windows power-plan switching directly from the desktop context menu.

![PRIMES Power Plan Switcher](docs/power%20plan%20menu.png)

A lightweight open-source utility written in AutoHotkey that detects your Windows power plans and lets you switch between them instantly without navigating through the Control Panel or Windows Settings. 

## Features
* **Zero Background Processes:** Executes only when clicked from the menu.
* **Native Windows Integration:** Embeds cleanly into the desktop right-click menu via registry keys.
* **Dynamic Detection:** Uses Windows `powercfg` to identify and switch to active power plans.
* **Custom Crimson Dark GUI:** Styled with a custom theme for quick visual feedback.

---

## Testing & Previews

> **Note:** The screenshots below were captured by the creator during personal testing of PRIMES Power Plan Switcher to demonstrate native plan detection and Windows context menu integration.

### Context Menu Integration
![Context Menu Demo](docs/hero-image.png)

---

## How It Works

```text
User Right-Clicks Desktop
       ↓
Selects Power Plan via Context Menu
       ↓
PRIMES Power Plan Switcher
       ↓
Windows powercfg.exe
       ↓
Power Plan Changes Instantly
