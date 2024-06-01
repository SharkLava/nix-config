{pkgs, ...}: let
  my-python-packages = p:
    with p; [
      pandas
      numpy
      scikit-learn
      ipykernel
      black
      python-lsp-server
    ];
in {
  environment.systemPackages = [
    (pkgs.python3.withPackages my-python-packages)
  ];
}
