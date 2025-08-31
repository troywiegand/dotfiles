{
  description = "Home Manager configuration of troy";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    # declaratively manage flatpaks
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    ghostty.url = "github:ghostty-org/ghostty";

    catppuccin.url = "github:catppuccin/nix";

    # configure neovim and neovim plugins with nix
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = { home-manager, nixpkgs-stable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true; # remove this
        overlays = [];
      };
    in {
      nixosConfigurations."simic" = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ( import ./hosts/simic/configuration.nix )
        ];
        specialArgs = { inherit inputs; };
      };
      
      nixosConfigurations."azorius" = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ( import ./hosts/azorius/configuration.nix )
        ];
        specialArgs = { inherit inputs; };
      };
      
      nixosConfigurations."orzhov" = nixpkgs-stable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ( import ./hosts/orzhov/configuration.nix )
        ];
        specialArgs = { inherit inputs; };
      };

      homeConfigurations."troy" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./users/troy.nix 
        ];
        extraSpecialArgs = { inherit inputs; };
      };

      homeConfigurations."troy@simic" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./users/simic.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      homeConfigurations."troy@azorius" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./users/azorius.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
      homeConfigurations."troy@orzhov" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./users/orzhov.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
