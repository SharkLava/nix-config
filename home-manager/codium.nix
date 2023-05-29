{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    package = pkgs.vscodium;
    extensions = [
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.ms-python.vscode-pylance
      pkgs.vscode-extensions.ms-pyright.pyright
      pkgs.vscode-extensions.njpwerner.autodocstring
      pkgs.vscode-extensions.jdinhlife.gruvbox
      pkgs.vscode-extensions.ms-toolsai.jupyter
    ];
    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Hard";
    };
  };
}
