{ pkgs, ... }:

{
  imports = [
    ../../../../apps
    ../../../../profiles
  ];

  metronome = {
    profiles = {
      desktops.hyprland.enable = true;
      dev = {
        cpp.enable = true;
        node.enable = true;
      };
    };

    apps = {
      antigravity.enable = true;
      direnv.enable = true;

      git = {
        enable = true;
        name = "Amal C.S";
        email = "amal4cs@gmail.com";
      };

      mpd.enable = true;
      mpv.enable = true;
      pipewire = {
        configFile = ../../config/pipewire/99-2.1-crossover.conf;
      };
      posting.enable = true;
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
  ];

}
