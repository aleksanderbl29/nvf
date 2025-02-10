{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    packages."aarch64-darwin" = let
      neovimConfigured = (inputs.nvf.lib.neovimConfiguration {
        inherit (nixpkgs.legacyPackages."aarch64-darwin") pkgs;
        modules = [{
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
        }];
      });
    in {
      # Set the default package to the wrapped instance of Neovim.
      # This will allow running your Neovim configuration with
      # `nix run` and in addition, sharing your configuration with
      # other users in case your repository is public.
      default = neovimConfigured.neovim;
    };
  };
}
