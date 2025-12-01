# 🐳 Alpine Linux .NET 9 PDE (Portable Development Environment)

[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/gbad8/portable-dotnet-developer-environment?label=Docker%20Hub&color=blue)](https://hub.docker.com/r/gbad8/portable-dotnet-developer-environment)

A lightweight, fully reproducible, containerized development environment for **C# (.NET 9)** and **ASP.NET Core**, powered by **Alpine Linux** and **Neovim (NvChad)**.

This project takes the manual configuration concepts from [Ramboe's guide](https://git.ramboe.io/YouTube/neovim-c-the-actually-improved-configuration-2025-roslynnvim-rzslnvim/) by Ramboe. and encapsulates them into a single, automated Docker image.

## 🎯 The Goal

The primary goal is to solve the "works on my machine" problem while keeping the image size optimized. By using this image, you get a pristine, pre-configured development environment with:
* **Zero Config:** Neovim plugins and LSPs are installed during the Docker build process (Headless mode).
* **Portability:** Works identically on Windows, Linux, and macOS.
* **Persistence:** Your source code remains on your local machine, mapped via Docker volumes.
* **Lightweight:** Built on Alpine Linux to minimize storage and memory footprint.

## ✨ Features & Tech Stack

* **Base:** Alpine Linux (3.22) for a fast build process and small image
* **Runtime/SDK:** .NET 9 SDK (includes **ASP.NET Core Runtime** for Web/Blazor development).
* **Editor:** Neovim (v0.10+) with **NvChad**.
* **C# Intelligence:** `roslyn.nvim` (Official Microsoft Roslyn LSP).
* **Database Tools:** Entity Framework Core installed and configured.
* **Utilities:** `tree`, `git`, `curl`, and other essential dev tools.

## :construction: Roadmap & Known Limitations

Since the migration to Alpine Linux (musl-based), some components require specific adaptations and are currently being implemented:

* **Implement Debugger:** Configure `netcoredbg` compatibility with Alpine.
* **Implement Razor Support:** Add `rzls` (Razor Language Server) for full Blazor support.
* **Implement Copilot:** Add GitHub Copilot support for AI assistance.

## 🔗 References & Credits

This project is a **implementation** of the configuration guide by **Ramboe**.

* **My Contribution:** I translated the manual steps into a transparent `Dockerfile`, migrated the base system to **Alpine Linux** for optimization, and automated the plugin installation process.
