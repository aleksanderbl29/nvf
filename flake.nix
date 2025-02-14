{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-flake = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    neovim-flake,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      neovimConfigured = neovim-flake.lib.${system}.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            config.vim = {
              viAlias = true;
              vimAlias = true;

              theme = {
                enable = true;
                name = "catppuccin";
                style = "mocha";
                transparent = true;
              };

              languages.nix.enable = true;
              dashboard.startify.enable = true;
              treesitter.enable = true;
              filetree.neo-tree.enable = true;
            };
          }
        ];
      };
    in {
      packages.default = neovimConfigured;
    });
}
