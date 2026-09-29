{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../packages/hyprland-system.nix

    ../../services

    ../../options.nix
  ];

  custom.services = {
    docker.enable = true;
    greetd.enable = true;
    nginx.enable = true;
    steam.enable = true;
  };
}
