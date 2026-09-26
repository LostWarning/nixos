{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/hyprland.nix
    ../../packages/mpd.nix
    ../../packages/neovim.nix
    ../../packages/quickshell.nix
    ../../packages/yazi.nix

    ../../modules/dev/cpp.nix

    ../../apps

    ../../packages/ssh.nix
  ];

  custom.apps = {
    btop.enable = true;

    direnv.enable = true;

    fish.enable = true;

    git.enable = true;
    google-chrome.enable = true;

    kitty.enable = true;

    posting.enable = true;

    mpv.enable = true;

    nautilus.enable = true;
    nodejs.enable = true;

    starship.enable = true;
    swayimg.enable = true;

    thunar.enable = true;
  };

  # Modules
  myCustom.dev.cpp.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
  ];
}
