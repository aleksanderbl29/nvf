{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          neovimConfigured = nvf.lib.neovimConfiguration {
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

                  languages = {
                    enableLSP = true;
                    enableFormat = true;
                    enableTreesitter = true;
                    nix = {
                      enable = true;
                      format = {
                        # Use nixfmt-rfc-style for automatic formatting
                        package = pkgs.nixfmt-rfc-style;
                      };
                    };
                    python.enable = true;
                    r = {
                      enable = true;
                      format.type = "styler";
                    };
                    ts.enable = true;
                  };

                  autocomplete.nvim-cmp = {
                    enable = true;
                  };

                  lsp = {
                    enable = true;
                    formatOnSave = true;
                  };

                  dashboard.startify.enable = true;
                  treesitter.enable = true;
                  filetree.neo-tree.enable = true;
                };
              }
            ];
          };
        in
        {
          default = neovimConfigured.neovim;
        }
      );
    };
}
