{ ... }:

{
  imports = [
    ./dev
    ./networking

    ./audio.nix
    ./display-manager.nix
    ./editor.nix
    ./games.nix
    ./terminal.nix
    ./window_manager.nix
  ];
}
