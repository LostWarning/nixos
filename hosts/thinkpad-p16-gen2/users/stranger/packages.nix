{ lib, pkgs, ... }:

let
  pipewireConfigFile = ./pipewire/99-2.1-crossover.conf;
in
{
  imports = [
    ../../../../packages/mpd.nix
    ../../../../packages/quickshell.nix

    ../../../../apps

    ../../../../packages/ssh.nix

    ../../../../modules/defaults.nix

    ./theme.nix
  ];

  metronome = {
    defaults = {
      desktop-environment = "hyprland";
      system-monitor = "btop";
      web-browser = "google-chrome";
      file-explorer = "nautilus";
      terminal = "kitty";

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

      mpv.enable = true;
      nodejs.enable = true;
      pavucontrol.enable = true;
      posting.enable = true;
      pwvucontrol.enable = true;
      swayimg.enable = true;
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    papirus-icon-theme
  ];

}
