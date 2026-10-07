{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.metronome.services.postgresql;
in
{
  options.metronome.services.postgresql = {
    enable = lib.mkEnableOption "PostgreSQL database service";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.postgresql_16;
      description = "PostgreSQL package to use";
    };

    initialDatabases = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Databases to ensure exist on startup";
    };
  };

  config = lib.mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      package = cfg.package;

      enableTCPIP = true;
      port = 5432;

      ensureDatabases = cfg.initialDatabases;
      ensureUsers = map (db: {
        name = db;
        ensureDBOwnership = true;
      }) cfg.initialDatabases;

      # Allow local Unix sockets via peer, and local TCP/IP via password (scram-sha-256)
      authentication = pkgs.lib.mkOverride 10 ''
        # TYPE  DATABASE  USER     ADDRESS         METHOD
        local   all       all                      peer
        host    all       all      127.0.0.1/32    scram-sha-256
        host    all       all      ::1/128         scram-sha-256
      '';
    };
  };
}
