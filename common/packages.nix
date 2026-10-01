{ pkgs, ... }:

{

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    jq
    vim
    wget
    curl
  ];
}
