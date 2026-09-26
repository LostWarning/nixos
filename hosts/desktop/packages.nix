{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
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
    ../../packages/yazi.nix

    ../../modules/dev/cpp.nix

    ../../apps

    ../../packages/ssh.nix
  ];

  custom.apps.btop.enable = true;
  custom.apps.thunar.enable = true;

  myCustom.dev.cpp.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    nautilus
  ];
}
