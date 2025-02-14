{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      neovimConfigured = inputs.nvf.lib.neovimConfiguration {
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
      packages.default = neovimConfigured.neovim;
    });
}
