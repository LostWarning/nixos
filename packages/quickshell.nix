{ pkgs, inputs, ... }:

{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  home.packages = with pkgs; [
    qt6.qtwayland
    qt6.qt5compat
    qt6.qtshadertools
    qt6.qtdeclarative
  ];
}
