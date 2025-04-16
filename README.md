# 🌌 Nixverse

Nixverse is a comprehensive, modular Nix configuration system designed to make your development environment and system configuration manageable, reproducible, and delightful.

## ✨ Features

- 🧩 **Modular Design** - Organized structure for Darwin (macOS), Home-Manager, and NixOS configurations
- 🛠️ **Dev Shells** - Pre-configured development environments for various languages and tools
- 🔄 **Easy Updates** - Simple commands to update and rebuild your system
- 🧰 **Custom Overlays** - Enhanced package definitions and fixes
- 🔒 **Secret Management** - Integration with `sops-nix`
- 🐟 **Fish Shell** - Optimized fish shell configuration with useful aliases and plugins

## 🗂️ Project Structure

```
nixverse/
├── flake.nix         # Main entry point for the flake
├── flake.lock        # Lock file with pinned dependencies
└── nix/              # Core configuration directory
    ├── default.nix   # Main configuration
    ├── devShells.nix # Development shell environments
    ├── configurations/
    │   ├── darwin/   # macOS specific configurations
    │   └── home/     # Home-manager configurations
    ├── modules/
    │   ├── darwin/   # Darwin modules
    │   ├── home/     # Home-manager modules
    │   ├── nixos/    # NixOS modules
    │   ├── flake/    # Flake-specific modules
    │   └── cross/    # Cross-platform modules
    └── overlays/     # Package overlays
```

## 🚀 Getting Started

### Prerequisites

- Nix package manager with flakes enabled
- Git

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/budhilaw/nixverse.git ~/.config/nixverse
   ```

2. Build and switch to the configuration:
   ```bash
   # For macOS
   darwin-rebuild switch --flake ~/.config/nixverse
   
   # For NixOS
   sudo nixos-rebuild switch --flake ~/.config/nixverse
   
   # For home-manager standalone
   home-manager switch --flake ~/.config/nixverse
   ```

## 🧠 Development Shells

Nixverse provides various pre-configured development environments that you can enter with:

```bash
# For Node.js environments
nix develop ~/.config/nixverse#nodejs14
nix develop ~/.config/nixverse#nodejs18
nix develop ~/.config/nixverse#nodejs20
nix develop ~/.config/nixverse#nodejs22

# For Go environments
nix develop ~/.config/nixverse#go

# For OCaml/Reason/Melange
nix develop ~/.config/nixverse#ocaml
nix develop ~/.config/nixverse#melange

# For Rust
nix develop ~/.config/nixverse#rust-wasm
```

## 🛠️ Useful Commands

Nixverse comes with many useful aliases (configured in `modules/home/shells.nix`):

- `drs` - Rebuild and switch Darwin configuration
- `flakeup-all` - Update all flake inputs
- `flakeup <input>` - Update a specific flake input
- `nclean` - Clean up Nix store

## 📝 Customization

### Adding a New Home Configuration

1. Create a new configuration file in `nix/configurations/home/`
2. Import it in your flake configuration

### Adding a New System Package

Add it to the appropriate configuration file in your modules.

## 🔄 Updating

Update all inputs:

```bash
nix flake update ~/.config/nixverse
```

Update a specific input:

```bash
nix flake lock ~/.config/nixverse --update-input nixpkgs
```

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## 📄 License

This project is licensed under the MIT License.

## 👤 Author

- **Ericsson Budhilaw** - [GitHub](https://github.com/budhilaw)

## 🔗 Related Projects

- [NixOS](https://nixos.org/)
- [home-manager](https://github.com/nix-community/home-manager)
- [nix-darwin](https://github.com/LnL7/nix-darwin)
- [flake-parts](https://github.com/hercules-ci/flake-parts)

## 🙏 Acknowledgements

- [Universe by r17x](https://github.com/r17x/universe)
