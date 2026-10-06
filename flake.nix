{
  description = "Modular NixOS Flake Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Quickshell official flake repository
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkHost =
        {
          host,
          system ? "x86_64-linux",
          users ? [ "stranger" ],
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/${host}/hardware-configuration.nix
            ./hosts/${host}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ]
          ++ (map (user: ./hosts/${host}/users/${user}) users)
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          host = "desktop";
          users = [ "stranger" ];
        };

        thinkpad-p16-gen2 = mkHost {
          host = "thinkpad-p16-gen2";
          users = [ "stranger" ];
        };
      };
    };
}
