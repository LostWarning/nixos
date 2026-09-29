{ ... }:

{
  imports = [
    ../../packages/ollama.nix
    ../../packages/steam.nix

    ../../packages/hyprland-system.nix

    ../../services
  ];

  custom.services = {
    docker.enable = true;
    nginx.enable = true;
    pipewire.enable = true;
    #postgresql.enable = true;
  };
}
