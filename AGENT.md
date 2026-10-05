# 🤖 Metronome — AI Agent Operating Instructions & Guidelines

This document provides definitive instructions, protocols, and architectural rules for any AI agent interacting with, refactoring, or extending the **Metronome** NixOS & Home Manager configuration repository.

---

## 🏛️ 1. Core Architecture & Mental Model

Metronome is a **declarative, role-driven, and multi-user ready** NixOS configuration built on Nix Flakes and Home Manager. It enforces strict separation of concerns across a 3-tier model:

```
┌──────────────────────────────────────────────────────────────────────────┐
│                          Tier 3: Personas (hosts/)                       │
│  - Machine Persona: hosts/<host>/configuration.nix                       │
│  - User Persona:    hosts/<host>/users/<user>/packages.nix               │
└────────────────────────────────────┬─────────────────────────────────────┘
                                     │ Enables profiles & machine overrides
                                     ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                 Tier 2: Profiles & Defaults (profiles/)                  │
│  - Defaults Schema: profiles/defaults.nix (central slots)                │
│  - Profiles:        profiles/desktops/*.nix, profiles/dev/*.nix          │
│    (PURE COMPOSITION: sets defaults + lib.mkDefault true on apps)        │
└────────────────────────────────────┬─────────────────────────────────────┘
                                     │ Composes & activates
                                     ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                 Tier 1: Atomic Apps & Services (apps/, services/)        │
│  - User Apps:        apps/<app>/ (Home Manager modules, metronome.apps)  │
│  - System Services:  services/<srv>/ (NixOS modules, metronome.services)│
└──────────────────────────────────────────────────────────────────────────┘
```

### Directory Structure & Responsibilities
- **`apps/`**: Self-contained Home Manager modules defining userland applications, configurations, and dotfiles. Exposes `metronome.apps.<name>.enable`. Aggregated in [`apps/default.nix`](file:///etc/nixos/apps/default.nix).
- **`services/`**: Self-contained NixOS modules defining root systemd daemons, background services, and hardware/system configurations. Exposes `metronome.services.<name>.enable`. Aggregated in [`services/default.nix`](file:///etc/nixos/services/default.nix).
- **`profiles/`**: Workflow compositions (e.g. desktop environments like Hyprland, dev stacks like C++ or Rust). **Profiles contain NO raw packages or dotfiles**—they purely set `metronome.defaults.*` and flip `metronome.apps.*.enable = lib.mkDefault true;`. Also holds [`profiles/defaults.nix`](file:///etc/nixos/profiles/defaults.nix).
- **`hosts/`**: Machine-specific configurations.
  - `thinkpad-p16-gen2` (laptop)
  - `desktop` (workstation)
  - Each host has its machine-level `configuration.nix` and user-level `users/<username>/packages.nix`.
- **`common/`**: Universal system baselines: fonts ([`common/fonts.nix`](file:///etc/nixos/common/fonts.nix)), locales, bootloader, weekly garbage collection.
- **`hardware/`**: Modular hardware modules and vendor graphics drivers managed via `metronome.hardware.gpu = "intel" | "amd"`, alongside machine-specific hardware profiles (`hardware/laptop/thinkpad/p16-gen2.nix`).

---

## 📋 2. Mandatory Protocol for Package & Service Requests

When the user asks to **"install a package"**, **"add an application"**, or **"set up a service"**, the agent MUST strictly execute the following 5-step workflow:

### Step 1: Inquire Target System & Scope
**NEVER assume where to install software.** The agent must explicitly ask the user:
1. **Target Machine(s)**:
   - `thinkpad-p16-gen2` (Laptop)
   - `desktop` (Workstation)
   - Both / All systems
2. **Context & Scope**:
   - Is it for the primary user (`stranger`), system-wide, or part of a shared workflow profile (e.g., `profiles/desktops/hyprland.nix` or a development profile)?

> [!TIP]
> Use clear, concise questions or interactive choice prompts to clarify the target host and context before writing code.

---

### Step 2: Provide Architectural Recommendations & Configuration
Before implementing, evaluate the package and provide expert recommendations to the user:
1. **Module Classification**:
   - **User App (`apps/`)**: If it's a CLI tool, desktop application, or editor used by the user.
   - **System Service (`services/`)**: If it runs as a system-wide background daemon, requires root privileges, modifies kernel modules, or binds to privileged ports (e.g., Docker, PipeWire, Nginx, PostgreSQL, Greetd).
   - **Default Slot (`profiles/defaults.nix`)**: If it fulfills an essential system/user role (terminal, text editor, file manager, web browser, system monitor, shell).
   - **Ad-hoc Package**: Only place raw packages in `home.packages` if it is a truly trivial one-off CLI tool with no configuration needed.
2. **Sensible Default Configurations**:
   - Check if the application has dotfiles or configuration options. Recommend best practices (e.g. Tokyonight theme alignment, Wayland native flags like `NIXOS_OZONE_WL = "1"`, GPU acceleration, shell integrations).
3. **Companion Dependencies**:
   - Recommend any required companion tools, plugins, fonts, or language servers (e.g., recommending `fd` and `ripgrep` with Telescope; recommending `wl-clipboard` for Wayland copy-paste; recommending formatters for Neovim).

---

### Step 3: Create the Atomic Module

#### A. Creating a User App Module (`apps/`)
1. Create a file or folder: `apps/<app_name>.nix` or `apps/<app_name>/<app_name>.nix`.
2. Define the option under `metronome.apps.<app_name>.enable`.
3. If it matches a default slot in `profiles/defaults.nix`, tie its default to `isDefault`:
   ```nix
   let
     cfg = config.metronome.apps.mytool;
     isDefault = (config.metronome.defaults.terminal == "mytool");
   in
   {
     options.metronome.apps.mytool = {
       enable = lib.mkOption {
         type = lib.types.bool;
         default = isDefault;
         description = "Enable mytool";
       };
     };
     config = lib.mkIf cfg.enable {
       programs.mytool.enable = true; # or home.packages = [ pkgs.mytool ];
     };
   }
   ```
4. **Always register the new module** in [`apps/default.nix`](file:///etc/nixos/apps/default.nix).

#### B. Creating a System Service Module (`services/`)
1. Create `services/<service_name>.nix`.
2. Define `metronome.services.<service_name>.enable`.
3. Wrap NixOS system settings:
   ```nix
   { config, pkgs, lib, ... }:
   let
     cfg = config.metronome.services.myservice;
   in
   {
     options.metronome.services.myservice = {
       enable = lib.mkEnableOption "myservice system daemon";
     };
     config = lib.mkIf cfg.enable {
       services.myservice.enable = true;
     };
   }
   ```
4. **Always register the new module** in [`services/default.nix`](file:///etc/nixos/services/default.nix).

#### C. Extending the Defaults Schema (`profiles/defaults.nix`)
If the new software represents a role or default handler (e.g. a new browser or file explorer):
1. Add the enum value to the corresponding option in [`profiles/defaults.nix`](file:///etc/nixos/profiles/defaults.nix).
2. Wire `isDefault` in the app module.

---

### Step 4: Enable on the Target Host Persona

Once the module is created and registered:
- **For User Apps**:
  Enable in `hosts/<host>/users/<user>/packages.nix`:
  ```nix
  metronome.apps.<app_name>.enable = true;
  ```
  *(Or if it is a default tool, set `metronome.defaults.<slot> = "<app_name>";`)*
- **For System Services**:
  Enable in `hosts/<host>/configuration.nix`:
  ```nix
  metronome.services.<service_name>.enable = true;
  ```
- **For Desktop-wide Profile Inclusions**:
  If the app belongs to all Hyprland users, enable it with `lib.mkDefault true` inside [`profiles/desktops/hyprland.nix`](file:///etc/nixos/profiles/desktops/hyprland.nix).

---

### Step 5: Verification & Testing Checklist

> [!CRITICAL]
> **Git Flake Rule**: Nix Flakes only see files that are tracked by Git. Whenever you create a new file, you MUST stage it or add it to Git index (`git add -N <path>`), otherwise Nix evaluation will fail with "path does not exist".

Execute this verification sequence:
1. **Stage new files**:
   ```bash
   git add -N apps/<new_app>.nix services/<new_service>.nix
   ```
2. **Evaluate target host configuration**:
   ```bash
   # For ThinkPad
   nix eval .#nixosConfigurations.thinkpad-p16-gen2.config.system.build.toplevel.drvPath

   # For Desktop (when testing desktop)
   nix eval .#nixosConfigurations.desktop.config.system.build.toplevel.drvPath
   ```
3. **Verify evaluation is clean**: Ensure there are no unhandled option warnings, missing attribute errors, or broken dependencies.

---

## 🚫 3. Anti-Patterns & Strict "Do NOTs"

- ❌ **Do NOT dump packages randomly**: Never append packages directly into `hosts/*/configuration.nix` `environment.systemPackages` or `hosts/*/users/*/packages.nix` `home.packages` without first considering if it warrants an atomic module.
- ❌ **Do NOT put packages or dotfiles in `profiles/`**: Profiles must remain pure compositions (`lib.mkDefault`). They compose apps and defaults; they do not define implementations.
- ❌ **Do NOT hardcode usernames or home paths**: Never use `/home/stranger` in modules or profiles. Use `${config.home.homeDirectory}` or Home Manager abstractions (`xdg.configHome`, `xdg.dataFile`).
- ❌ **Do NOT use runtime binary installers (FHS anti-patterns)**: Never use tools like `mason.nvim`, `nvm`, or external binary curl-installers that download precompiled binaries into `~/.local`. Always package dependencies declaratively through `pkgs.*` or Nix flakes.
- ❌ **Do NOT mix System and User concerns**:
  - Root daemons, hardware drivers, system firewalls belong in `services/` (NixOS).
  - Terminal emulators, GUI user apps, desktop keybindings, shell configs belong in `apps/` (Home Manager).

---

## 📦 4. Module Templates

### Template A: User Application (`apps/<name>.nix`)
```nix
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.apps.<name>;
  # Optional: Tie to defaults slot if applicable:
  # isDefault = (config.metronome.defaults.<slot> == "<name>");
in
{
  options.metronome.apps.<name> = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false; # or `default = isDefault;`
      description = "Enable <name> application";
    };
  };

  config = lib.mkIf cfg.enable {
    # If package has a Home Manager module:
    programs.<name> = {
      enable = true;
    };

    # Or if installing raw package + dotfiles:
    # home.packages = with pkgs; [ <name> ];
    # xdg.configFile."<name>/config".text = ''...'';
  };
}
```

### Template B: System Service (`services/<name>.nix`)
```nix
{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.metronome.services.<name>;
in
{
  options.metronome.services.<name> = {
    enable = lib.mkEnableOption "<name> system service";
  };

  config = lib.mkIf cfg.enable {
    services.<name> = {
      enable = true;
    };

    # Optional firewall or system dependencies:
    # networking.firewall.allowedTCPPorts = [ ... ];
  };
}
```

### Template C: Composable Profile (`profiles/<category>/<name>.nix`)
```nix
{ lib, ... }:

{
  options.metronome.profiles.<category>.<name> = {
    enable = lib.mkEnableOption "<name> workflow profile";
  };

  config = lib.mkIf config.metronome.profiles.<category>.<name>.enable {
    # Set default handlers for this workflow
    metronome.defaults = {
      terminal = lib.mkDefault "kitty";
      text-editor = lib.mkDefault "nvim";
    };

    # Enable required atomic apps with mkDefault so users can override
    metronome.apps = {
      git.enable = lib.mkDefault true;
      direnv.enable = lib.mkDefault true;
    };
  };
}
```
