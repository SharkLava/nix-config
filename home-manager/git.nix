{pkgs, ...}: {
  programs = {
    gh = {
      enable = true;
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      lfs.enable = false;
      userEmail = "kalathilvishal1@gmail.com";
      userName = "Vishal Kalathil";
      extraConfig = {
        core.editor = "${pkgs.helix}/bin/hx";
        difftool.prompt = true;
        github.user = "SharkLava";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        mergetool.prompt = true;
        pull.ff = "only";
      };
    };
  };
}
