{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fira-mono
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
    ollama
    # tesseract
    gitFull
    # mysql-workbench
  ];
}
