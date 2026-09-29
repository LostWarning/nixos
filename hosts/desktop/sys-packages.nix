{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../packages/hyprland-system.nix

    ../../services
  ];

  custom.services = {
    docker.enable = true;
    greetd.enable = true;
    nginx.enable = true;
    pipewire.enable = true;
    #postgresql.enable = true;
    steam.enable = true;
  };
}
