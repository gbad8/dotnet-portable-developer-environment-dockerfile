# **🐳 Arch Linux .NET 9 PDE (Portable Development Environment)**

This repository contains a Docker image that provides a complete, "battery-included" development environment for C# (.NET 9) and Blazor, powered by **Neovim (NvChad)**.

The configuration is based on the guide ["The Actually Improved C# Configuration (2025)"](https://git.ramboe.io/YouTube/neovim-c-the-actually-improved-configuration-2025-roslynnvim-rzslnvim/#configure-neovim-for-c), but fully automated. It handles the installation of all dependencies, Language Servers (LSP), and Debuggers (DAP) so you can **just run and code**.

## ✨ Key Features

* **Base:** Arch Linux.
* **Editor:** Neovim with the **NvChad** preset (fast, beautiful, and Lua-based).
* **Dev tools:** .NET SDK 9.0, ASP.NET runtime and Entity Framework.
* **Intellisense (LSP):**
    * **C#:** `roslyn.nvim` (utilizing the official Microsoft Roslyn Language Server).
    * **Blazor/Razor:** `rzls.nvim` (full support for .razor files).
* **Debugging (DAP):** Pre-configured `netcoredbg` with a user interface (`nvim-dap-ui`) for a "IDE" debugging experience.
* **Testing:** Integrated unit testing via `neotest-dotnet`.
* **Zero Config:** Everything is "baked" into the image via the Dockerfile.

---

## 🚀 Quick Start

To launch the environment and start developing, run the command below. It will pull the image and mount your current local folder inside the container.

### Basic Command

```bash
docker run -it --name csharp-env -v $(pwd):/home/gbad8/Work -w /home/gbad8/Work -p 8000:8080 gbad8/portable-dotnet-developer-environment:v4-arch-stable
```
 
### Understanding the flags:
* `-it`: Ensures interactive mode (essential for running Neovim).
* `--name csharp-env`: Assigns a name to the container for easier management (start/stop).
* `-v $(pwd):/home/gbad8/Work`: Maps your current local folder to the container's workspace. Any file you save inside the container is persisted to your local disk.
* `-p 8000:8080`: Opens a door to the container at 8000, so when you run dotnet run --urls "http://0.0.0.0:8000", you can access the project from the outside. 
---

## ⌨️ Usage Guide

Once inside the container terminal, simply type `nvim` to open the editor.

### 1. NvChad Core Commands
* **Space + ff**: Find Files.
* **Space + fw**: Live Grep (find text inside files).
* **Space + th**: Open floating terminal.
* **gd**: Go to Definition.
* **K**: Show Documentation (Hover).


### 2. Debugging Shortcuts (DAP)
The container comes with DAP fully configured. Use these keys to control execution:

| Key | Function |
| :--- | :--- | :--- |
| **F5** | Start / Continue Debugging |
| **F9** | Toggle Breakpoint |
| **F10** | Step Over |
| **F11** | Step Into |
| **F8** | Step Out |
| **Space + dr** | Open Debug Console (REPL) |


---

## 🛠️ Technical Notes

This image was built especially for .NET developers who wants to avoid the manual configuration steps usually required for Roslyn and NvChad. It's Dockerfile uses a headless build process to:
* Install `roslyn` and `rzls` via Mason during the build.
* Compile Treesitter parsers for C# and Razor.
* Inject the necessary Lua configurations into the correct paths.

**Requirements:** Docker installed. No local .NET or Neovim dependencies are required.

## 🚧 Roadmap & Limitations

The core development loop (Edit -> Run -> Debug) is fully functional. The current focus is on polish and tooling expansion:

* [x] **Implement Debugger:** `netcoredbg` is now fully integrated.
* [x] **Implement Entity Framework.**
* [x] **Implement Razor Support:** `rzls` added for Blazor development.
* [ ] **Terminal Aesthetics:** Improve fonts, colors, and shell prompt (currently using raw bash).
* [ ] **SQL Tools:** Add `sqlcmd` (Go version) for database management inside the container.
* [ ] **AI Assistance:** Configure GitHub Copilot.
* [ ] **Complete Alpine image:** So we can have a smaller image.
