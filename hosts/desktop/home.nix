{
  config,
  ...
}:

{
  imports = [
    ../../common/xdg.nix
    ./packages.nix
  ];

  home.username = "stranger";
  home.homeDirectory = "/home/stranger";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
