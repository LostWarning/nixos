{
  pkgs,
  ...
}:

{
  imports = [
    ../../common/nixos.nix
    ../../common/locale/india.nix
    ../../common/env_variables.nix
    ../../common/services.nix
    ../../common/fonts.nix

    ../../services
    ../../hardware

    ./networking.nix
    ./filesystem.nix

    ../../profiles/defaults.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    jq
    wget
    curl
  ];

  metronome = {
    hardware = {
      gpu = "amd";
      displays = {
        "DP-1" = {
          mode = "3840x2160@120";
          position = "1080x0";
          scale = 1.5;
          vrr = 2;
          bitdepth = 10;
          cm = "auto";
          primary = true;
          workspaces = [
            1
            2
            3
            4
            5
          ];
        };
        "DP-2" = {
          mode = "1920x1080@60";
          position = "0x0";
          scale = 1.0;
          transform = 3;
          bitdepth = 8;
          cm = "auto";
          workspaces = [
            6
            7
            8
            9
          ];
        };
      };
    };

    defaults = {
      display-manager = "greetd";
      web-server = "nginx";
      audio-backend = "pipewire";
      shell = "fish";
      shell-prompt = "starship";
    };

    services = {
      docker.enable = true;
      hyprland.enable = true;
      ollama.enable = true;
      ssh.enable = true;
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
