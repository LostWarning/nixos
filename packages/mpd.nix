{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpc
    playerctl
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/stranger/Music";
    playlistDirectory = "/home/stranger/Music/playlists";

    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "PipeWire Sound Server"
      }
    '';
  };

  services.mpdris2 = {
    enable = true;
  };
}
