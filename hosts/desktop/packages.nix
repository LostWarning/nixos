{ pkgs, ... }:

{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/hyprland.nix
    ../../packages/mpd.nix
    ../../packages/neovim.nix
    ../../packages/quickshell.nix
    ../../packages/yazi.nix

    ../../apps
    ../../modules

    ../../packages/ssh.nix
  ];

  custom.apps = {
    btop.enable = true;
    bun.enable = true;

    direnv.enable = true;

    git.enable = true;
    google-chrome.enable = true;

    pavucontrol.enable = true;
    posting.enable = true;
    pwvucontrol.enable = true;

    mpv.enable = true;

    nautilus.enable = true;
    nodejs.enable = true;

    swayimg.enable = true;

    thunar.enable = true;
  };

  # Modules
  myCustom.dev.cpp.enable = true;

  custom.modules = {
    terminal.enable = true;
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
  ];
}
