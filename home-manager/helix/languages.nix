{
  pkgs,
  lib,
  ...
}: {
  language-server = {
    vscode-css-language-server = {
      command = "css-language-server";
      args = ["--stdio"];
      config = {provideFormatter = true;};
    };
    vscode-html-language-server = {
      command = "html-language-server";
      args = ["--stdio"];
      config = {provideFormatter = true;};
    };
    vscode-json-language-server = {
      command = "vscode-json-languageserver";
      args = ["--stdio"];
      config = {provideFormatter = true;};
    };
    clangd = {command = "clangd";};
    haskell-language-server = {
      command = "haskell-language-server-wrapper";
      args = ["--lsp"];
    };
    markdoc-ls = {
      command = "markdoc-ls";
      args = ["--stdio"];
    };
    marksman = {
      command = "marksman";
      args = ["server"];
    };
    nil = {command = "nil";};
    pylsp = {command = "pylsp";};
    yaml-language-server = {
      command = "yaml-language-server";
      args = ["--stdio"];
    };
    bash-language-server = {
      command = "bash-language-server";
      args = ["start"];
    };
  };
  language = [
    {
      name = "nix";
      formatter = {
        command = "nixpkgs-fmt";
      };
    }
    {
      name = "json";
      formatter = {
        args = ["--parser" "json"];
        command = "prettier";
      };
    }
  ];
}
