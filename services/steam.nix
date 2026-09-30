{ config, lib, ... }:

let
  games = config.metronome.games;
in
{

  config = lib.mkIf (games.enable && games.steam.enable) {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
    };
  };
}
