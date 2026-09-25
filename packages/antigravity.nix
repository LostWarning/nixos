# packages/antigravity.nix
{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = [
    inputs.llm-agents.packages.${system}.antigravity-cli
  ];
}
