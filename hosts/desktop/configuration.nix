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

    ../../options.nix

  ];

  nixpkgs.config.allowUnfree = true;

  services.dbus.implementation = "broker";

  networking.hostName = "nixos"; # Define your hostname.

  custom.window_manager = "hyprland";

  custom.audio.backend = "pipewire";

  custom.terminal = {
    emulator = "kitty";
    shell = "fish";
    prompt = "starship";
  };

  custom.editors = {
    neovim.enable = true;
    default = "neovim";
  };

  custom.dev = {
    cxx.enable = true;
    typescript.enable = true;
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
