{ pkgs, ... }:

{
  imports = [
    ../packages/fish.nix
    ../packages/fonts.nix
    ../packages/pipewire.nix
  ];

  environment.systemPackages = with pkgs; [
    btrfs-progs
    jq
    vim
    wget
    curl
  ];
}
