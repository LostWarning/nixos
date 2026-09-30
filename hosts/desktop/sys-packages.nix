{ ... }:

{
  imports = [
    ../../packages/ollama.nix

    ../../services

  ];

  custom.services = {
    docker.enable = true;
    steam.enable = true;
  };
}
