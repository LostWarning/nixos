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

    ../../services

    ../../hardware/laptop/thinkpad/p16-gen2.nix

    ./networking.nix
    ./fonts.nix

    ../../modules

    ../../apps/fish.nix
    ../../apps/starship.nix

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

  environment.systemPackages = with pkgs; [
    jq
    wget
    curl
  ];

  metronome = {

    defaults = {
      display-manager = "greetd";
      shell = "fish";
      shell-prompt = "starship";
      web-server = "nginx";
      audio-backend = "pipewire";
    };

    services = {
      docker.enable = true;
      hyprland.enable = true;
      ollama.enable = false;
      steam.enable = false;
    };

    editors = {
      neovim.enable = true;
      default = "neovim";
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
