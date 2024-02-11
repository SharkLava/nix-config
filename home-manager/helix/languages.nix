{...}: {
  language-server = {
    clangd = { command = "clangd"; };
    nil = { command = "nil"; };
    pylsp = { command = "pylsp"; };
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
  ];
}
