# NixVerse 🌌

<div align="center">
  
![Nix](https://img.shields.io/badge/Nix-5277C3?style=for-the-badge&logo=nixos&logoColor=white)
![Darwin](https://img.shields.io/badge/Darwin-000000?style=for-the-badge&logo=apple&logoColor=white)
![WSL](https://img.shields.io/badge/WSL-4D4D4D?style=for-the-badge&logo=windows&logoColor=white)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

</div>

A highly modular, cross-platform Nix flake configuration for macOS (Darwin) and WSL environments. Designed to be reproducible, composable and maintainable.

## 🌟 Features

- **Cross-platform**: Works seamlessly on macOS (aarch64-darwin) and Ubuntu WSL (x86_64-linux)
- **Modular architecture**: Clean separation between system, home, and shell configurations
- **Development environments**: Preconfigured dev shells for various languages and stacks
- **Git integration**: Proper GPG signing setup and SSH configuration
- **Custom packages**: Configuration for both system and user-level packages

## 📋 System Requirements

- **macOS**: 11.0 or later (Big Sur+), Apple Silicon or Intel
- **WSL**: Ubuntu 22.04+ (or other distros with compatibility)
- **Nix**: 2.4 or later with flakes support enabled

## 🚀 Quick Start

### Prerequisites

1. Install Nix package manager:
   ```bash
   sh <(curl -L https://nixos.org/nix/install) --daemon
   ```

2. Enable flakes in `/etc/nix/nix.conf` or `~/.config/nix/nix.conf`:
   ```
   experimental-features = nix-command flakes
   ```

### Installation

1. Clone this repository:
   ```bash
   mkdir -p ~/.config
   git clone git@github.com:budhilaw/nixverse.git ~/.config/nixverse
   cd ~/.config/nixverse
   ```

2. Apply configuration for your platform:

   #### macOS (nix-darwin)
   ```bash
   # First time setup
   nix build .#darwinConfigurations.budhilaw.system
   ./result/sw/bin/darwin-rebuild switch --flake .

   # Subsequent updates
   darwin-rebuild switch --flake .#budhilaw
   ```

   #### WSL
   There are two options for WSL, depending on whether you're using NixOS-WSL or Ubuntu WSL:

   **For NixOS WSL** (if you've installed NixOS in WSL):
   ```bash
   # Apply system and home configurations
   nixos-rebuild switch --flake .#budhilaw
   ```

   **For Ubuntu WSL** (standard Ubuntu WSL with Nix package manager):
   ```bash
   # Using Home Manager in standalone mode
   nix run home-manager/master -- switch --flake .#budhilaw@ubuntu
   ```

## 🧰 Development Environments

Preconfigured development shells for various languages and ecosystems:

```bash
# Go development
nix develop .#go

# Rust with WASM support
nix develop .#rust-wasm

# Rust with screen capture capabilities
nix develop .#rust-cap

# Node.js environments (14, 18, 20, 22)
nix develop .#nodejs14
nix develop .#nodejs18
nix develop .#nodejs20
nix develop .#nodejs22

# Bun runtime
nix develop .#bun
```

## 🏗️ Project Structure

```
nixverse/
├── flake.nix       # Main entry point for the Nix flake
├── flake.lock      # Pinned dependencies
└── nix/            # Core configuration directory
    ├── default.nix # Main configuration import
    ├── hosts/      # Host-specific configurations
    ├── home/       # Home Manager modules
    │   ├── git.nix      # Git configuration
    │   ├── gpg.nix      # GPG configuration
    │   ├── ssh.nix      # SSH configuration
    │   ├── packages.nix # User packages
    │   └── tmux.nix     # Terminal multiplexer config
    ├── nixosModules/    # System modules 
    │   ├── darwin/      # macOS-specific modules
    │   └── linux/       # Linux/WSL-specific modules
    ├── overlays/        # Package overlays
    └── devShells.nix    # Development environment definitions
```

## 🔄 Updating

To update and apply changes:

```bash
# Pull latest changes
cd ~/.config/nixverse
git pull

# Update flake inputs (optional)
nix flake update

# Apply configuration using platform-specific command
darwin-rebuild switch --flake .                            # macOS
nixos-rebuild switch --flake .#budhilaw                    # NixOS WSL
nix run home-manager/master -- switch --flake .#budhilaw@ubuntu  # Ubuntu WSL
```

## 🛠️ Customization

### Adding Custom Packages

1. For system packages, modify `nix/nixosModules/[platform]/packages.nix`
2. For user packages, modify `nix/home/packages.nix`

### Creating New Development Shells

Add new environments to `nix/devShells.nix`

## 💫 Inspiration & Credits

This project was inspired by and draws upon ideas from several amazing Nix configurations in the community:

- [**r17x/universe**](https://github.com/r17x/universe) - A comprehensive Nix configuration with excellent structure and development environments
- [**malob/nixpkgs**](https://github.com/malob/nixpkgs) - Well-designed Darwin configuration with practical abstractions

Special thanks to the Nix community for sharing knowledge and configurations that make projects like this possible.

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for more details. 