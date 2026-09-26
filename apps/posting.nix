{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.posting.enable = lib.mkEnableOption "Posting: REST API TESTING";

  config = lib.mkIf config.custom.apps.posting.enable {
    home.packages = with pkgs; [
      posting
    ];

    xdg.configFile."posting/config.yaml".text = ''
      theme: "tokyo-night"
      editor: "nvim"
    '';
  };
}
