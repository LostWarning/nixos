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
    ../../common/display.nix
    ../../hardware/gpu/amd.nix

    ../../common/networking.nix

    ./filesystem.nix
    ./display.nix

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
    networking.hostName = "desktop";

    defaults = {
      desktop-environment = "hyprland";
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
