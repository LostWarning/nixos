{ ... }:

{
  imports = [
    ../../packages/nginx.nix
    ../../packages/ollama.nix
    ../../packages/steam.nix

    ../../packages/hyprland-system.nix

    ../../services
  ];

  custom.services = {
    docker.enable = true;
    #postgresql.enable = true;
  };
}
