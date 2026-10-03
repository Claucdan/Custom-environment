{
  description = "NixOS system and personal dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    codex-nixpkgs.url = "github:NixOS/nixpkgs/master";
  };

  outputs = { nixpkgs, codex-nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/hosts/nixos ];
      specialArgs = {
        codexPkgs = codex-nixpkgs.legacyPackages.x86_64-linux;
      };
    };
  };
}
