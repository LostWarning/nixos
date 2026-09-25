# ❄️ Modular NixOS Configuration

A clean, scalable, and fully modular NixOS configuration powered by **Flakes** and **Home Manager**. Designed with a strict "single source of truth" philosophy to decouple hardware, system services, user identities, and application packages.

## 📂 Repository Architecture

.
├── flake.nix                  # Master orchestrator for flake inputs, hosts, and user binding
├── hardware-configuration.nix   # Machine-specific kernel and disk auto-generated bindings
├── common/                    # Universal defaults shared across all systems
│   ├── nixos.nix              # Core Nix settings, GC, and flakes enablement
│   ├── home.nix               # Shared Home Manager blueprint (XDG dirs, session vars)
│   ├── services.nix           # System-wide services (audio, udisks, networkmanager)
│   ├── env_variables.nix      # Global environment & session variables
│   ├── locale/                # Timezone and internationalization settings
│   └── display_manager/       # Login managers (e.g., greetd)
├── hosts/                     # Machine-specific entry points
│   └── desktop/               # Target machine configuration ("nixos")
│       ├── configuration.nix  # Host-level service assembly
│       ├── sys-packages.nix   # Host-specific system packages (Steam, Ollama, Nginx)
│       ├── hardware.nix       # Hardware drivers (e.g., AMD GPU)
│       ├── filesystem.nix     # Mount points and swap files
│       └── packages.nix       # User-facing application bundle for this host
├── users/                     # User identity sources of truth
│   └── stranger.nix           # User metadata, system account rules, and exported modules
├── hardware/                  # Reusable hardware profiles (e.g., GPU configurations)
└── packages/                  # Modular application configurations (Neovim, Hyprland, MPV, etc.)

## 🏛️ Design Philosophy

This repository is structured around four foundational architectural pillars:

1. Single Source of Truth (SSOT): User metadata (username, full name, email) and system account specifications are encapsulated within their own dedicated files (e.g., users/stranger.nix). These fields are exported upward and dynamically injected into both NixOS and Home Manager via flake.nix. Changing your identity details in one place propagates automatically across the entire system.

2. Strict Separation of Concerns:
- System vs. User: Low-level system daemons, hardware drivers, and kernel parameters live in system configurations, while user applications, dotfiles, and shell preferences are handled via Home Manager.
- Universal vs. Host-Specific: common/ holds bare-minimum settings that apply universally. hosts/ isolates machine-specific capabilities (such as heavy GPUs, secondary storage pools, or host-tailored system packages like Steam and Ollama).

3. Symmetrical Scalability: Adding a new machine or a new user follows a repeatable, predictable pattern. Deploying to a laptop in the future will only require creating a new hosts/laptop/ directory while reusing the exact same common/ infrastructure and users/ definitions.

4. Modular Composition: Instead of massive, monolithic configuration files, every application (packages/neovim.nix, packages/yazi.nix, etc.) and system module is isolated into its own file. Features are enabled simply by pulling them into an import list like building blocks.

## 🚀 Usage & Rebuilding

To update or rebuild your system configuration using this flake, run:
sudo nixos-rebuild switch --flake /etc/nixos#nixos

To clean up old system and user generations and optimize storage:
sudo nix-collect-garbage --delete-older-than 7d
