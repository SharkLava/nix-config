{ pkgs
, lib
, ...
}:
{
  xdg.configFile =
    let
      settingsFormat = pkgs.formats.toml { };
      genText = x: y: builtins.readFile (settingsFormat.generate x y);
    in
    {
      "helix/languages.toml".text =
        genText "config.toml" (import ./languages.nix { inherit pkgs lib; });
      "helix/themes/catppuccin_macchiato.toml".text =
        genText "catppuccin_macchiato.toml" (import ./catppuccin_macchiato.nix);
    };

  # lsps
  home.packages = with pkgs;[
    rust-analyzer
    nil
    shfmt
    nixpkgs-fmt
    rustfmt
    clang-tools
    haskell-language-server
  ]
  ++ (with pkgs.nodePackages_latest; [
    vscode-json-languageserver-bin
    vscode-html-languageserver-bin
    vscode-css-languageserver-bin
    prettier
  ]);

  programs.helix = {
    enable = true;
    package = pkgs.helix;

    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        line-number = "relative";
        auto-pairs = true;
        true-color = true;
        cursorline = true;
        color-modes = true;
        soft-wrap = { enable = false; };

        lsp = {
          enable = true;
          display-messages = true;
          display-inlay-hints = true;
          snippets = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "┊";
        };

        file-picker.hidden = false;

        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
        };

      };

      keys.normal = {
        space = {
          s = ":w";
          m = ":format";
          q = ":q!";
        };

    };
  };
}
