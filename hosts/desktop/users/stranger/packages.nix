{ pkgs, ... }:

{
  imports = [
    ../../../../apps
    ../../../../profiles
  ];

  metronome = {
    defaults = {
      desktop-environment = "hyprland";
      system-monitor = "btop";
      web-browser = "google-chrome";
      file-explorer = "nautilus";
      terminal = "kitty";
      text-editor = "nvim";
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
      pavucontrol.enable = true;
      posting.enable = true;
      pwvucontrol.enable = true;
      quickshell.enable = true;
      ssh.enable = true;
      swayimg.enable = true;
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
