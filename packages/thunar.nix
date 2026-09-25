{ config, pkgs, ... }:

{
  # 1. Install Thunar and recommended plugins
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin # For right-click extract/compress
    thunar-volman # For automatic management of removable drives
    file-roller # Archive backend manager for Thunar
  ];

}
