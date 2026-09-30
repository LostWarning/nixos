{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../services

  ];

  custom.services = {
    docker.enable = true;
    nginx.enable = true;
    steam.enable = true;
  };
}
