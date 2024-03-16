{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bottom
    openssl
    pkg-config
    gcc
    lldb
    black
    clang-tools
    cmake
    gnumake
    nil
    helix
    wget
    # tesseract
    gitFull
    # mysql-workbench
    gnome-text-editor
    alejandra
    typst
    typstfmt
    rustup
    # globalprotect-openconnect
    mpi
    amass
  ];
}
