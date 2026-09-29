{ config, lib, ... }:

{
  options.custom.services.steam.enable = lib.mkEnableOption "steam";

  config = lib.mkIf config.custom.services.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
    };
  };
}
