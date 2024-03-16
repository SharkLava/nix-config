{ ... }: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      font = "FiraCode Nerd Font 12";
    };
  };
}
