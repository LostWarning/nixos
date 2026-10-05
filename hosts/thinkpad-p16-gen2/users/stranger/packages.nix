{ pkgs, ... }:

{
  imports = [
    ../../../../apps
    ../../../../profiles
  ];

  metronome = {
    profiles = {
      desktops.hyprland.enable = true;
    };

    apps = {
      antigravity.enable = true;
      bun.enable = true;
      direnv.enable = true;

      git = {
        enable = true;
        name = "Amal C.S";
        email = "amal4cs@gmail.com";
      };

      mpd.enable = true;
      mpv.enable = true;
      nodejs.enable = true;
      posting.enable = true;
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    wl-clipboard
    hyprshot
  ];

}
