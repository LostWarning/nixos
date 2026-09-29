{ ... }:

{
  imports = [
    ./docker.nix
    ./nginx.nix
    ./pipewire.nix
    ./postgresql.nix
  ];
}
