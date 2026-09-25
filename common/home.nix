{
  config,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./xdg.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
