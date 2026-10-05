{ config, lib, ... }:

let
  cfg = config.metronome.services.steam;
in
{
  options.metronome.services.steam = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable steam";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
    };
  };
}
