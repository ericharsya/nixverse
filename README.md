# Nixverse - Cross-Platform Nix Configuration

This repository contains my personal Nix configuration for macOS and Ubuntu WSL environments.

## Supported Platforms

- **macOS** (aarch64-darwin)
- **Ubuntu WSL** (x86_64-linux)

## Setup

### Prerequisites

- Install Nix package manager:
  ```bash
  sh <(curl -L https://nixos.org/nix/install) --daemon
  ```

- Enable flakes (create or edit `/etc/nix/nix.conf`):
  ```
  experimental-features = nix-command flakes
  ```

### Installation

1. Clone this repository:
   ```bash
   mkdir -p ~/.config
   git clone https://github.com/budhilaw/nixverse.git ~/.config/nixverse
   cd ~/.config/nixverse
   ```

2. Apply configuration based on your platform:

## Usage

### macOS (nix-darwin)

Apply the configuration:
```bash
# First time
nix build .#darwinConfigurations.budhilaw.system
./result/sw/bin/darwin-rebuild switch --flake .

# Subsequent updates
darwin-rebuild switch --flake .#budhilaw
```

### Ubuntu WSL

Use Home Manager in standalone mode:
```bash
# Install home-manager if not already installed
nix run nixpkgs#home-manager

# Apply the configuration
nix run home-manager/master -- switch --flake .#budhilaw@ubuntu
```

### Development Environments

Access development shells:
```bash
# Go development shell
nix develop .#go

# Rust development shell
nix develop .#rust-wasm
```

## Structure

- **nix/** - Core configuration directory
  - **hosts/** - Host-specific configurations
  - **home/** - Home Manager modules
  - **nixosModules/** - System modules for NixOS and nix-darwin
  - **overlays/** - Package overlays

## Maintenance

To update and apply changes:

1. Pull the latest changes:
   ```bash
   cd ~/.config/nixverse
   git pull
   ```

2. Apply the configuration using your platform-specific command from above

## License

This project is licensed under the MIT License. 