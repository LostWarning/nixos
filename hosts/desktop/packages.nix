{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/mpd.nix
    ../../packages/quickshell.nix
    ../../packages/yazi.nix

    ../../apps

    ../../packages/ssh.nix
  ];

  custom.apps = {
    btop.enable = true;
    bun.enable = true;

    direnv.enable = true;

    git.enable = true;
    google-chrome.enable = true;

    posting.enable = true;

    mpv.enable = true;

    nautilus.enable = true;
    nodejs.enable = true;

    swayimg.enable = true;

    thunar.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
  ];
}
