{...}: {
  programs.# Helix
    helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        true-color = true;
        # bufferline = "multiple";
        line-number = "relative";
        cursorline = true;
        whitespace.render = "all";
        # whitespace.render.space = "all";
        # whitespace.render.tab = "all";
        # whitespace.render.newline = "none";
        indent-guides.render = true;
        # indent-guides.character = "╎";
        indent-guides.character = "|";
        file-picker.hidden = false;
        file-picker.git-ignore = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        # It's quite helpful, but the placement is a bit annoying
        # editor.lsp.auto-signature-help = false;
        lsp.display-messages = true;
      };
      keys.insert.j = {k = "normal_mode";}; # Maps `jk` to exit insert mode
    };
    languages = [
      {
        name = "nix";
        auto-format = true;
        formatter = {command = "alejandra";};
      }
      {
        name = "julia";
        auto-format = true;
      }
      {
        name = "haskell";
        auto-format = true;
        formatter = {command = "fourmolu -i";};
      }
      {
        name = "latex";
        auto-format = true;
        formatter = {command = "latexindent";};
      }
      {
        name = "rust";
        auto-format = true;
        formatter = {command = "rustfmt";};
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
        formatter = {command = "black";};
      }
    ];
  };
}
