# ManageWSLInstance.ps1

PowerShell script to manage Windows Subsystem for Linux (WSL) instances.

---

## 📋 Overview

This script automates the following WSL tasks:

- Terminates a running WSL instance
- Unregisters an existing WSL instance
- Imports a `.tar` backup as a fresh WSL instance

---

## 🚀 Usage

```powershell
.\ManageWSLInstance.ps1 -InstanceName "MyDistro" -TarFileName "UbuntuBackup.tar"
