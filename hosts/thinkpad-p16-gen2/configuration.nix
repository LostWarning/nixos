{
  pkgs,
  ...
}:

{
  imports = [

    ../../common/nixos.nix
    ../../common/locale/india.nix
    ../../common/env_variables.nix
    ../../common/packages.nix
    ../../common/services.nix

    ../../services

    ../../hardware/laptop/thinkpad/p16-gen2.nix
    ./fonts.nix

    ../../modules

    ../../apps/bun.nix
    ../../apps/btop.nix
    ../../apps/direnv.nix
    ../../apps/google-chrome.nix
    ../../apps/nautilus.nix
    ../../apps/nodejs.nix
    ../../apps/pavucontrol.nix
    ../../apps/posting.nix
    ../../apps/pwvucontrol.nix

    ../../modules/defaults.nix

  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa.opencl
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "thinkpad-p16-gen2"; # Define your hostname.

  metronome = {

    defaults = {
      file-explorer = "nautilus";
      system_monitor = "btop";
      web-browser = "google-chrome";
    };

    apps = {
      bun.enable = true;
      direnv.enable = true;
      nodejs.enable = true;
      pavucontrol.enable = true;
      posting.enable = true;
      pwvucontrol.enable = true;
    };

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

    containers = {
      enable = true;
      docker.enable = true;
    };

    ai = {
      enable = false;
      engine = {
        ollama.enable = false;
      };
    };

    games = {
      enable = false;
      steam.enable = false;
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
