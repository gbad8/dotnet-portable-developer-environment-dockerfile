# 🐳 Arch Linux .NET 9 PDE (Portable Development Environment)

[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/gbad8/portable-dotnet-developer-environment?label=Docker%20Hub&color=blue)](https://hub.docker.com/r/gbad8/portable-dotnet-developer-environment)

A fully reproducible, containerized development environment for **C# (.NET 9)** and **ASP.NET Core**, powered by **Arch Linux** and **Neovim (NvChad)**.

This project takes the manual configuration concepts from **Ramboe's** guide and encapsulates them into a single, automated Docker image. No manual installation steps required.

## 🎯 The Goal

The primary goal is to solve the "works on my machine" problem. By using this image, you get a pristine, pre-configured development environment with:
* **Zero Config:** Neovim plugins, LSPs, and Debuggers are installed during the Docker build process (Headless mode).
* **Portability:** Works identically on Windows, Linux, and macOS.
* **Persistence:** Your source code remains on your local machine, mapped via Docker volumes.

## ✨ Features & Tech Stack

* **Base:** Arch Linux (Rolling Release) for the latest packages.
* **Runtime/SDK:** .NET 9 SDK (includes **ASP.NET Core Runtime** for Web/Blazor development).
* **Editor:** Neovim (v0.10+) with **NvChad**.
* **C# Intelligence:** * `roslyn.nvim` (Official Microsoft Roslyn LSP).
    * `rzls.nvim` (Razor/Blazor support).
* **Debugging:** `netcoredbg` fully configured with `nvim-dap-ui`.
* **Testing:** `neotest-dotnet` integration.

## 🔗 References & Credits

This project is a **containerized implementation** of the configuration guide by **Ramboe**.

* **Original Guide:** [The Actually Improved C# Configuration (2025)](https://git.ramboe.io/YouTube/neovim-c-the-actually-improved-configuration-2025-roslynnvim-rzslnvim/) by Ramboe.
* **My Contribution:** I'm on the process to translate the manual steps from the guide into a transparent `Dockerfile`, automated the "Headless" installation of Mason/Treesitter, and optimized the environment for Docker usage.
