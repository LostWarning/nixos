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

    direnv.enable = true;

    git.enable = true;
    google-chrome.enable = true;

    posting.enable = true;

    mpv.enable = true;

    swayimg.enable = true;

  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    papirus-icon-theme
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      sort-directories-first = true;
    };
  };
}
