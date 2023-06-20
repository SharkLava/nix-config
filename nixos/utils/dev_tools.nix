{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    alejandra
    nerdfonts
    bottom
    openssl
    pkg-config
    gcc
    lldb
    black
    clang-tools
    cmake
    nil
    helix
    wget
    tesseract
    gitFull
    mysql-workbench
    gtk3
    qtcreator
  ];
}
