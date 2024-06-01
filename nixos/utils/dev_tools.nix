{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bottom
    (pkgs.ollama.override { acceleration = "cuda"; })
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
    # amass
    oterm
    tmux
    jan

    micromamba

    pango
    gtk4
    gtk3
    cairo
    glib

    cppcheck
  ];
}
