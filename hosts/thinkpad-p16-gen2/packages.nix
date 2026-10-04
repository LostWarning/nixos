{ lib, pkgs, ... }:

let
  pipewireConfigFile = ./pipewire/99-2.1-crossover.conf;
in
{
  imports = [
    ../../packages/antigravity.nix
    ../../packages/mpd.nix
    ../../packages/quickshell.nix

    ../../apps

    ../../packages/ssh.nix

    ./theme.nix
  ];

  custom.apps = {

    git.enable = true;

    mpv.enable = true;

    swayimg.enable = true;

  };

  home.packages = with pkgs; [
    brightnessctl
    networkmanagerapplet
    blueman
    papirus-icon-theme
  ];

  xdg.configFile."pipewire/pipewire.conf.d/99-system.conf" =
    lib.mkIf (builtins.pathExists pipewireConfigFile)
      {
        source = pipewireConfigFile;
      };
}
