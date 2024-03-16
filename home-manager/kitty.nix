{
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font";
    font.size = 11;
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      mouse_hide_wait = 2;
      cursor_shape = "block";
      url_color = "#0087bd";
      url_style = "dotted";
      #Close the terminal =  without confirmation;
      confirm_os_window_close = 0;
      hide_window_decorations = "yes";
    };
    theme = "seoulbones_light";
  };
}
