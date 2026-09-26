{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.apps.google-chrome.enable = lib.mkEnableOption "Google chrome";

  config = lib.mkIf config.custom.apps.google-chrome.enable {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
