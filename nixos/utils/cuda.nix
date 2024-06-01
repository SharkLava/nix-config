{pkgs, ...}: {
  environment.systemPackages = with pkgs.cudaPackages; [
    cudatoolkit
    # cudnn
    # cuda_nvcc
    # nccl
  ];
}
