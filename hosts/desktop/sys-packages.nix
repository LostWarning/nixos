{ pkgs, ... }:

{
  imports = [
    ../../packages/nginx.nix
    ../../packages/ollama.nix
    ../../packages/steam.nix

    ../../packages/hyprland-system.nix
  ];

  environment.systemPackages = with pkgs; [ ];
}
