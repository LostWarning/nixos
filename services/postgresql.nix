{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  options.custom.services.postgresql.enable = lib.mkEnableOption "PostgreSQL";

  config = lib.mkIf config.custom.services.postgresql.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql;

      enableTCPIP = true;
      port = 5432;

      ensureDatabases = [
        username
      ];

      ensureUsers = [
        {
          name = username;
          ensureDBOwnership = true;
        }
      ];

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
