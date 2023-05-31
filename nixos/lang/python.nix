{pkgs, ...}: let
  my-python-packages = p:
    with p; [
      pandas
      numpy
      scikit-learn
      ipykernel
      black
      matplotlib
      seaborn
      beautifulsoup4
      # tensorflowWithCuda
      keras
      torch
      flask
      openpyxl
      autopep8
      pytesseract
      python-lsp-server
      tkinter
      (opencv4.override {
        enableGtk2 = true;
        enableGtk3 = true;
      })
      # other python packages
    ];
in {
  environment.systemPackages = [
    (pkgs.python3.withPackages my-python-packages)
  ];
}
