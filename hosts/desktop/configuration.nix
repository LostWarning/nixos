{
  ...
}:

{
  imports = [

    ../../common/nixos.nix
    ../../common/locale/india.nix
    ../../common/env_variables.nix
    ../../common/packages.nix
    ../../common/services.nix

    ./sys-packages.nix
    ./hardware.nix
    ./filesystem.nix

    ../../modules

  ];

  nixpkgs.config.allowUnfree = true;

  services.dbus.implementation = "broker";

  networking.hostName = "nixos"; # Define your hostname.

  metronome = {
    display_manager = "greetd";

    window_manager = "hyprland";

    audio.backend = "pipewire";

    terminal = {
      emulator = "kitty";
      shell = "fish";
      prompt = "starship";
    };

    editors = {
      neovim.enable = true;
      default = "neovim";
    };

    networking = {
      http_server = {
        enable = true;
        backend = "nginx";
      };
    };

    dev = {
      cxx.enable = true;

      typescript = {
        enable = true;
        nodejs.enable = true;
        bun.enable = true;
      };
    };

    games = {
      enable = true;
      steam.enable = true;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
