{ ... }:

{
  imports = [
    ./docker.nix
    ./greetd.nix
    ./nginx.nix
    ./pipewire.nix
    ./postgresql.nix
  ];
}
