# 🐳 Ubuntu 26.04 .NET 10 PDE (Portable Development Environment)

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![.NET](https://img.shields.io/badge/.NET%2010-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?style=for-the-badge&logo=neovim&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

This repository contains a Dockerfile that provides a complete, **"battery-included"** development environment for C# (.NET 10) and Blazor, powered by **Neovim (LazyVim)**.

It is designed to be a zero-config, portable solution: just build the container, and you have a full IDE experience ready to go.

<p align="center">
  <img src="/demo.jpeg" alt="Texto Alternativo" width="100%">
</p>

## ✨ Key Features

* **Base OS:** Ubuntu 26.04.
* **Editor:** Neovim with the **LazyVim** preset (fast, beautiful, and Lua-based).
* **Dev Tools:** .NET SDK 10.0, ASP.NET runtime, and Entity Framework.
* **Intellisense (LSP):**
    * **C#:** `roslyn.nvim` (utilizing the official Microsoft Roslyn Language Server).
    * **Blazor/Razor:** `rzls.nvim` (full support for `.razor` files).
* **Debugging (DAP):** Pre-configured `netcoredbg` with a user interface (`nvim-dap-ui`) for a full debugging experience.
* **Testing:** Integrated unit testing via `neotest-dotnet`.
* **Zero Config:** Everything is "baked" into the image via the Dockerfile.

---

## 🚀 Getting Started

Follow these steps to build and run the environment locally from the source code.

### 1. Clone the repository
```bash
git clone https://github.com/gbad8/dotnet-portable-developer-environment-dockerfile.git)](https://github.com/gbad8/dotnet-portable-developer-environment-dockerfile.git/
```

### 2. Enter the directory
```bash
cd dotnet-portable-developer-environment-dockerfile
```

### 3. Build the Docker Image
Build the image tagging it as `dotnet-pde` (or any name you prefer).
*Note: This might take a minute as it compiles Treesitter parsers and installs plugins.*

```bash
docker build -t dotnet-pde .
```

### 4. Run the Container
Run the command below to launch the container. This will mount your current directory inside the container, allowing you to edit files on your host machine while using the container's tools.

```bash
docker run -it --rm \
  --name csharp-env \
  -v $(pwd):/home/portabledev/Work \
  -w /home/portabledev/Work \
  -p 8000:8080 \
  dotnet-pde
```

#### Understanding the flags:
* `-it`: Ensures interactive mode (essential for running Neovim).
* `--rm`: Automatically removes the container when you exit (keeps your docker clean).
* `-v $(pwd):/home/portabledev/Work`: Maps your current local folder to the container's workspace. **Any file you save inside is persisted to your local disk.**
* `-p 8000:8080`: Exposes port 8080 inside the container to port 8000 on your machine (useful for web apps).

---

## ⌨️ Usage Guide

Once inside the container terminal, simply type `nvim` to open the editor.

### 1. LazyVim Core Commands

| Shortcut | Description |
| :--- | :--- |
| **Space + ff** | Find Files |
| **Space + fw** | Live Grep (search text across all files) |
| **Space + th** | Open floating terminal |
| **gd** | Go to Definition |
| **K** | Show Documentation (Hover) |

### 2. Debugging Shortcuts (DAP)

The container comes with DAP fully configured. Use these keys to control execution:

| Key | Function |
| :--- | :--- |
| **F5** | Start / Continue Debugging |
| **F9** | Toggle Breakpoint |
| **F10** | Step Over |
| **F11** | Step Into |
| **F8** | Step Out |
| **Space + dr** | Open Debug Console (REPL) |

---

## 🛠️ Technical Notes

This image was built specifically for .NET developers who want to avoid the complex manual configuration steps usually required for Roslyn and Neovim integration.

The `Dockerfile` uses a **headless build process** to:
1.  Install `roslyn` via Mason during the build phase.
2.  Compile Treesitter parsers for C# and Razor.
3.  Inject the necessary Lua configurations into the correct paths.

**Requirements:** You only need Docker installed. No local .NET or Neovim dependencies are required on your host machine.

---

## 🚧 Roadmap & Limitations

The core development loop (Edit -> Run -> Debug) is fully functional. The current focus is on polish and tooling expansion:

- [x] **Implement Debugger:** `netcoredbg` is now fully integrated.
- [x] **Implement Entity Framework.**
- [x] **Implement Razor Support:** `rzls` added for Blazor development.
- [ ] **Terminal Aesthetics:** Improve fonts, colors, and shell prompt.
- [ ] **AI Assistance:** Configure GitHub Copilot.

---

## 🔗 Collaboration

Contributions are welcome! If you find a bug or want to improve the Lua configs, feel free to open an issue or submit a Pull Request.

**SOLI DEO GLORIA**
