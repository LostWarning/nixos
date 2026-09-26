{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/direnv.nix
    ../../packages/googlechrome.nix
    ../../packages/hyprland.nix
    ../../packages/mpd.nix
    ../../packages/neovim.nix
    ../../packages/npm.nix
    ../../packages/quickshell.nix
    ../../packages/starship.nix
    ../../packages/yazi.nix

    ../../modules/dev/cpp.nix

    ../../apps

    ../../packages/ssh.nix
  ];

  custom.apps = {
    btop.enable = true;

    fish.enable = true;

    git.enable = true;

    kitty.enable = true;

    posting.enable = true;

    mpv.enable = true;

    swayimg.enable = true;

    thunar.enable = true;
  };

  # Modules
  myCustom.dev.cpp.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    nautilus
  ];
}
