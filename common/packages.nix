{ pkgs, ... }:

{
  imports = [
    ../packages/fonts.nix
  ];

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    jq
    vim
    wget
    curl
  ];
}
