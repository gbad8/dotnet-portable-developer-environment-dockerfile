# Contribution Guide

Thank you for contributing to the **Arch Linux .NET 9 PDE**.

This project relies on community collaboration to maintain a robust, reproducible development environment. Whether you are optimizing Docker layers, updating Neovim plugins, or fixing upstream Arch Linux breakages, your help is welcome.

---

## 🛠 Development Workflow

We follow the standard **Fork & Pull Request** workflow.

### Local Testing
Since this is a Docker image, **build integrity is paramount**. Before submitting a PR, ensure the image builds successfully and the environment initializes correctly.

1.  **Build the image:**
    ```bash
    docker build -t arch-pde-test .
    ```
    *Pay attention to the "headless" installation steps (Lazy/Mason/Treesitter). Network timeouts or key verification errors must be resolved.*

2.  **Verify the container:**
    Ensure Neovim starts without Lua errors and .NET tools are in the `$PATH`:
    ```bash
    docker run -it --rm arch-pde-test nvim --headless "+checkhealth" +qa
    ```
3. **What about compose?**
   Note that this project includes another service, via a compose file. Feel free to add more services, but only those natural to .NET development.
---

## 📝 Commit Guidelines

We strictly follow **[Conventional Commits](https://www.conventionalcommits.org/)**. This enables automated changelog generation and semantic versioning.

| Type | Description |
| :--- | :--- |
| `feat` | New features (e.g., adding `sqlcmd`, new LSP). |
| `fix` | Bug fixes (e.g., fixing `pacman` keyring, path issues). |
| `docs` | Documentation changes only. |
| `style` | Formatting, missing semi-colons, etc; no code change. |
| `refactor` | Refactoring production code (e.g., optimizing Docker layers). |
| `test` | Adding missing tests or refactoring existing ones. |
| `chore` | Maintenance tasks (e.g., updating dependencies). |

**Example:** `feat: implement headless installation for rzls`

---

## 📮 Pull Request Process

1.  **Context:** Provide a clear description of **what** changed and **why**.
2.  **Dependencies:** If you added a new tool (e.g., via `pacman` or `dotnet tool`), explain the necessity.
3.  **Issues:** Link related issues (e.g., `Closes #12`).
4.  **History:** Please keep your branch history clean. Squash WIP commits before requesting review if necessary.

---

## 🐛 Issue Reporting

When reporting bugs via GitHub Issues, please include:
* Host OS and Docker version.
* Build logs (especially if related to `pacman` or `Mason` failures).
* Steps to reproduce.

Thanks for your support! 🐳
