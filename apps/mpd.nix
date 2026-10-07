{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.mpd;
  audioBackend = config.metronome.defaults.audio-backend;
  outputType = if audioBackend == "pulseaudio" then "pulse" else "pipewire";
  outputName = if audioBackend == "pulseaudio" then "PulseAudio Sound Server" else "PipeWire Sound Server";
in
{
  options.metronome.apps.mpd = {
    enable = lib.mkEnableOption "MPD music daemon";
    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra configuration appended to mpd.conf";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mpc
      playerctl
    ];

    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      playlistDirectory = "${config.home.homeDirectory}/Music/playlists";

      extraConfig = ''
        audio_output {
          type  "${outputType}"
          name  "${outputName}"
        }
        ${cfg.extraConfig}
      '';
    };

    services.mpdris2.enable = true; # Media keys & bar integration
  };
}
