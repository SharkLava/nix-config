{ pkgs
, lib
, ...
}: {
  language-server = {
    vscode-css-language-server = {
      command = "css-language-server";
      args = [ "--stdio" ];
      config = { provideFormatter = true; };
    };
    vscode-html-language-server = {
      command = "html-language-server";
      args = [ "--stdio" ];
      config = { provideFormatter = true; };
    };
    vscode-json-language-server = {
      command = "vscode-json-languageserver";
      args = [ "--stdio" ];
      config = { provideFormatter = true; };
    };
    clangd = { command = "clangd"; };
    haskell-language-server = {
      command = "haskell-language-server-wrapper";
      args = [ "--lsp" ];
    };
    markdoc-ls = {
      command = "markdoc-ls";
      args = [ "--stdio" ];
    };
    marksman = {
      command = "marksman";
      args = [ "server" ];
    };
    nil = { command = "nil"; };
    pylsp = { command = "pylsp"; };
    yaml-language-server = {
      command = "yaml-language-server";
      args = [ "--stdio" ];
    };
    bash-language-server = {
      command = "bash-language-server";
      args = [ "start" ];
    };
  };
  language = [
    {
      name = "nix";
      auto-format = true;
      formatter = { command = "nixpkgs-fmt"; };
    }
    {
      name = "json";
      auto-format = true;
      formatter = {
        args = [ "--parser" "json" ];
        command = "prettier";
      };
    }
    {
      name = "julia";
      auto-format = true;
    }
    {
      name = "haskell";
      auto-format = true;
      formatter = { command = "fourmolu -i"; };
    }
    {
      name = "latex";
      auto-format = true;
      formatter = { command = "latexindent"; };
    }
    {
      name = "rust";
      auto-format = true;
      formatter = { command = "rustfmt"; };
    }
    {
      name = "bash";
      auto-format = true;
    }
    {
      name = "c";
      auto-format = true;
    }
    {
      name = "cpp";
      auto-format = true;
    }
    {
      name = "sql";
      auto-format = true;
    }
    {
      name = "python";
      auto-format = true;
      formatter = {
        command = "black";
        args = [
          "-" # stdin
          "--quiet"
          "--line-length=79"
        ];
      };
    }
    {
      name = "javascript";
      auto-format = true;
      formatter = { command = "js-beautify -q"; };
    }
  ];
}
