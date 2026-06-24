# Lemmon-714

**Classification:** Private / Internal Use  
**Environment Target:** Ubuntu 24.04 (WSL2)  
**Project Context:** Naahvana (long-term)  

---

## Overview

Lemmon-714 is a modular, reproducible development environment for Ubuntu 24.04 running on WSL2. 

It is designed to:
* Maintain a clean and consistent system configuration across machines
* Reduce configuration drift through symlink-based architecture
* Provide a stable foundation for long-term systems work

## System Manifest

| Component | Specification |
| :--- | :--- |
| **OS** | Ubuntu 24.04 LTS (Noble Numbat) |
| **Shell** | Bash (customized via `.bashrc`) |
| **Runtime** | Node.js 24 |
| **Architecture** | GNU Stow (symlink management) |
| **Environment** | WSL2 (Windows Subsystem for Linux) |

## Directory Structure

The repository is organized into modular components:

```text
lemmon-714
├── .config/         # XDG configuration (starship, fastfetch, tmux)
├── shell/           # Bash and PowerShell environments
├── dev/             # Development environment
│   ├── vcs/         # Git configuration
│   ├── runtimes/    # Node.js, Python
│   └── editors/     # Cursor, VS Code
├── os/              # OS-level configuration
│   ├── linux/       # apt packages, bootstrap script
│   └── windows/     # winget packages, PowerShell bootstrap
├── scripts/         # Internal automation (install, doctor, repair)
└── Makefile         # Primary entry point
```

## Setup

### Prerequisites

* WSL2 with Ubuntu 24.04 installed
* `git`, `make`, and `stow`

Install dependencies:

```sh
sudo apt update
sudo apt install git make stow
```

## Usage

### Bootstrap (recommended)
```sh
make bootstrap
```
Performs initial system setup:
* Installs packages from `os/linux/apt.packages.list`
* Installs Starship prompt
* Enables True Color support

### Install (configs only)
```sh
make install
```
Deploys symlinks to the home directory:
* XDG configs (starship, fastfetch, tmux) → `~/.config/`
* Shell configs (.bashrc, .bash_aliases, .profile) → `~/`
* Git configs (.gitconfig, .gitignore_global) → `~/`
* Runtime configs (.npmrc, pip.conf) → `~/`, `~/.config/pip/`
* Editor settings (VS Code, Cursor) → WSL server paths

### Doctor (environment check)
```sh
make doctor
```
Validates system state:
* Required tools are installed
* Key configurations are present
* Environment is ready for development

## OS Configuration

### Linux (WSL2)
* **Package list:** `os/linux/apt.packages.list`
* **Bootstrap script:** `os/linux/bootstrap.sh`

### Windows
* **Bootstrap script:** `os/windows/bootstrap.ps1` (winget package installs)
* **Symlink engine:** `os/windows/sync.ps1`

## Makefile Commands

* `make bootstrap` → Full environment setup (packages + starship)
* `make install` → Deploy all configuration symlinks
* `make doctor` → Validate environment integrity
* `make repair` → Reset editor servers and dead IPC sockets
* `make flush` → Alias for `repair`
* `make backup-windows` → Export Windows app inventory

## Verification

After setup:

1. Open a new shell → confirm aliases and prompt are active
2. Run `node -v` → should reflect Node.js 24
3. Run `fastfetch` (if installed) → should reflect custom configuration

## Security

* **No secrets are tracked in this repository.**
* `.pem`, `.key`, and `.env` files are excluded.

**Local overrides:** `~/.bashrc_local`  
This file is ignored by version control.

**Commit integrity:** All commits should be signed using GPG.

## Philosophy

The environment is as important as the code.

A clean system enables clear thinking.

This setup is intended to evolve alongside long-term work, from early experimentation to production-grade systems.

## Notes

* Linux-first workflow within WSL2
* Scripts should be idempotent where possible
* Changes should prioritize stability and reproducibility over novelty
