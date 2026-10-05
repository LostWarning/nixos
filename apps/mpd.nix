{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.apps.mpd;
in
{
  options.metronome.apps.mpd = {
    enable = lib.mkEnableOption "MPD music daemon";
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
          type  "pipewire"                                                                                                                                                                                                                                      
          name  "PipeWire Sound Server"                                                                                                                                                                                                                         
        }                                                                                                                                                                                                                                                       
      '';
    };

    services.mpdris2.enable = true; # Media keys & bar integration
  };
}
