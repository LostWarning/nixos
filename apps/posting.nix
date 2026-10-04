{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  cfg = config.metronome.apps.posting;
in

{
  options.metronome.apps.posting = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "install posting";
    };
    color-theme = lib.mkOption {
      type = lib.types.enum [ "tokyo-night" ];
      default = "tokyo-night";
      description = "color theme";
    };
    editor = lib.mkOption {
      type = lib.types.enum [
        "nvim"
        "nano"
      ];
      default = "nano";
      description = "editor";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${username} = {
      home.packages = [ pkgs.posting ];

      xdg.configFile."posting/config.yaml".text = ''
        theme: "${cfg.color-theme}"
        editor: "${cfg.editor}"
      '';
    };
  };
}
