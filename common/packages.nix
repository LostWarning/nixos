{ pkgs, ... }:

{

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    jq
    wget
    curl
  ];
}
