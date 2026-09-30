{ lib, ... }:

{
  options.metronome.networking.http_server = {
    enable = lib.mkEnableOption "Enable HTTP web server";

    backend = lib.mkOption {
      type = lib.types.enum [
        "nginx"
        "apache"
      ];
      default = "nginx";
      description = "Select which http web server to use.";
    };
  };
}
