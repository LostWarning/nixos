{ lib, config, ... }:

{
  options.custom.services.nginx.enable = lib.mkEnableOption "nginx";

  config = lib.mkIf config.custom.services.nginx.enable {

    services.nginx = {
      enable = true;

      # Performance defaults
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;

      virtualHosts."localhost" = {
        # Path to your web assets (can be in /var/www or a local store path)
        root = "/var/www/html";

        locations."/" = {
          index = "index.html";
          tryFiles = "$uri $uri/ /index.html"; # SPA fallback for HTML apps
        };

        locations."~* \\.json$" = {
          extraConfig = ''
            add_header Content-Type application/json;
            add_header Access-Control-Allow-Origin *;
            expires -1;
          '';
        };

        # Optional: Read raw snippet files if you prefer external config files
        # extraConfig = builtins.readFile ./nginx/custom_vhost.conf;
      };

      # Append raw global configuration from a local file if needed:
      # appendHttpConfig = builtins.readFile ./nginx/nginx.conf;
    };

    # Open HTTP/HTTPS ports
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
