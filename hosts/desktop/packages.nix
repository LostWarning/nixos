{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/btop.nix
    ../../packages/direnv.nix
    ../../packages/fish.nix
    ../../packages/git.nix
    ../../packages/googlechrome.nix
    ../../packages/hyprland.nix
    ../../packages/kitty.nix
    ../../packages/mpd.nix
    ../../packages/mpv.nix
    ../../packages/neovim.nix
    ../../packages/npm.nix
    ../../packages/posting.nix
    ../../packages/quickshell.nix
    ../../packages/starship.nix
    ../../packages/swayimg.nix
    ../../packages/thunar.nix
    ../../packages/yazi.nix

    ../../modules/dev/cpp.nix

    ../../packages/ssh.nix
  ];

  myCustom.dev.cpp.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    nautilus
  ];
}
