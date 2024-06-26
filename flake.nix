{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      Omen = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    #homeConfigurations = {
    # FIXME replace with your username@hostname
    # "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
    #  pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    # extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
    # > Our main home-manager configuration file <
    # modules = [ ./home-manager/home.nix ];
    #};
    #};
  };
}
