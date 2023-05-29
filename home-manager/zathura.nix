{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      font = "FantasqueSansMono Nerd Font 12";
      recolor = true;
      default-bg = "#1D2021";
      default-fg = "#EBDBB2";
      statusbar-bg = "#504945";
      statusbar-fg = "#EBDBB2";
      inputbar-bg = "#1D2021";
      inputbar-fg = "#EBDBB2";
      notification-bg = "#1D2021";
      notification-fg = "#B8BB26";
      notification-error-bg = "#1D2021";
      notification-error-fg = "#FB4934";
      notification-warning-bg = "#1D2021";
      notification-warning-fg = "#FABD2F";
      highlight-color = "#FABD2F";
      highlight-active-color = "#FE8019";
      completion-bg = "#504945";
      completion-fg = "#EBDBB2";
      completion-highlight-bg = "#83A598";
      completion-highlight-fg = "#504945";
      completion-group-bg = "#3C3836";
      completion-group-fg = "#928374";
      recolor-lightcolor = "#1D2021";
      recolor-darkcolor = "#EBDBB2";
      index-fg = "#EBDBB2";
      index-bg = "#504945";
      index-active-fg = "#504945";
      index-active-bg = "#83A598";
      render-loading-bg = "#1D2021";
      render-loading-fg = "#EBDBB2";
    };
  };
}
