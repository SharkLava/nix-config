{ inputs
, lib
, config
, pkgs
, ...
}: {
  programs = {
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
    };
    git = {
      enable = true;
      difftastic = {
        enable = true;
        background = "dark";
        display = "side-by-side";
      };
      package = pkgs.gitFull;
      lfs.enable = false;
      userEmail = "kalathilvishal1@gmail.com";
      userName = "Vishal Kalathil";
      extraConfig = {
        core.editor = "${pkgs.helix}/bin/hx";
        diff = {
          colorMoved = "default";
          age.textconv = "${pkgs.rage}/bin/rage -i ~/.ssh/id_ed25519 --decrypt";
        };
        difftool.prompt = true;
        github.user = "SharkLava";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        mergetool.prompt = true;
        pull.ff = "only";

        credential = { credentialStore = "libsecret"; };

        aliases = {
          st = "status";
          co = "checkout";
          ci = "commit";
          br = "branch";
          lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
          recent = "for-each-ref --sort=-committerdate --format='%(committerdate:short): %(refname:short)' refs/heads/";
        };
      };
    };
  };
}
