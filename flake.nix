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
      user = import ./users/stranger.nix;
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            username = user.username;
          };

          modules = [
            ./hardware-configuration.nix
            ./hosts/desktop/configuration.nix

            user.nixosModule

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                username = user.username;
                fullName = user.fullName;
                email = user.email;
              };

              home-manager.users.${user.username} = {
                imports = [
                  ./common/home.nix
                  ./hosts/desktop/packages.nix
                ];
              };
            }
          ];
        };
      };
    };
}
