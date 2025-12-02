# 🐳 Arch Linux .NET 9 PDE (Portable Development Environment)

[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/gbad8/portable-dotnet-developer-environment?label=Docker%20Hub&color=blue)](https://hub.docker.com/r/gbad8/portable-dotnet-developer-environment)

A fully reproducible, containerized development environment for **C# (.NET 9)** and **ASP.NET Core**, powered by **Arch Linux** and **Neovim (NvChad)**.

This project implements the manual configuration concepts from [Ramboe's guide](https://git.ramboe.io/YouTube/neovim-c-the-actually-improved-configuration-2025-roslynnvim-rzslnvim/) but encapsulates them into a single, automated Docker image using "Headless" installation scripts.

## 🎯 The Goal

The primary goal is to solve the "works on my machine" problem. By using this image, you get a pristine, pre-configured development environment with:

* **Zero Config:** Neovim plugins, LSPs, and Debuggers are installed during the Docker build process.
* **Portability:** Works identically on Windows, Linux, and macOS.
* **Persistence:** Your source code remains on your local machine, mapped via Docker volumes.
* **Compatibility:** Built on **Arch Linux** to ensure full support for standard C libraries (glibc), required by complex tools like Roslyn and Netcoredbg.

> **Note on OS Choice:** We migrated from Alpine Linux back to Arch Linux. While Alpine is smaller, its `musl` C library causes friction with .NET debugging tools and Roslyn. Arch Linux provides the necessary `glibc` support and the latest packages ("bleeding edge") out of the box.

## ✨ Features & Tech Stack

* **Base:** Arch Linux (Rolling Release).
* **Runtime/SDK:** .NET 9 SDK (includes **ASP.NET Core Runtime** for Web/Blazor development).
* **Editor:** Neovim (v0.10+) with **NvChad**.
* **Language Servers (LSP):**
    * `roslyn.nvim`: Official Microsoft Roslyn LSP for C#.
    * `rzls.nvim`: Razor Language Server for full **Blazor** support.
* **Debugging:** `netcoredbg` fully configured with `nvim-dap-ui` for breakpoints and variable inspection.
* **Database Tools:** Entity Framework Core (`dotnet-ef`) installed globally.
* **Utilities:** `ripgrep`, `git`, `curl`, `fzf`, `make`, `gcc`.

## 🚀 Quick Start

To run the container and map your current folder as the workspace:

```bash
docker run -it --rm \
  --name dotnet-env \
  -v $(pwd):/home/gbad8/workspace \
  gbad8/portable-dotnet-developer-environment:latest
```

> *(On Windows CMD, replace `$(pwd)` with `%cd%`)*

### Key Bindings (NvChad Defaults)

| Action | Shortcut |
| :--- | :--- |
| **Find Files** | `<Space> + ff` |
| **File Explorer** | `<Ctrl> + n` |
| **Floating Term** | `<Space> + th` |
| **LSP Hover** | `K` |
| **Debug Start** | `F5` |
| **Toggle Breakpoint** | `F9` |

## 🚧 Roadmap & Limitations

The core development loop (Edit -> Run -> Debug) is fully functional. The current focus is on polish and tooling expansion:

* [x] **Implement Debugger:** `netcoredbg` is now fully integrated.
* [x] **Implement Razor Support:** `rzls` added for Blazor development.
* [ ] **Terminal Aesthetics:** Improve fonts, colors, and shell prompt (currently using raw bash).
* [ ] **SQL Tools:** Add `sqlcmd` (Go version) for database management inside the container.
* [ ] **AI Assistance:** Configure GitHub Copilot.

## 🔗 References & Credits

This project is a containerized implementation of the configuration guide by **Ramboe**.

* **Original Concept:** [The Actually Improved C# Configuration](https://git.ramboe.io/YouTube/neovim-c-the-actually-improved-configuration-2025-roslynnvim-rzslnvim/) by Ramboe.
* **My Contribution:** I translated the manual steps into a transparent `Dockerfile`, managed the transition to Arch Linux for tool compatibility, and automated the headless plugin installation process.

---
**License:** MIT
