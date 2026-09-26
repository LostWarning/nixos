{ pkgs, ... }:

{
  imports = [
    ../packages/fonts.nix
    ../packages/pipewire.nix
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
