{
  pkgs,
  username,
  homeDir,
  ...
}: {
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    alejandra
    clang-tools
    cmakeMinimal
    eza
    fd
    fish
    gcc
    gnumake
    jq
    # kitty
    lua-language-server
    meson
    neovim
    ninja
    nixd
    ripgrep
    sshfs
    stylua
    zig
    zls
    zoxide
  ];

  # TODO:
  # fonts = {
  #   fontconfig.enable = true;
  #   packages = [ pkgs.nerd-fonts.jetbrains-mono ];
  # };
  # TODO: Configure kitty

  xdg.configFile = {
    "nvim".source = ./nvim;
    "fish/config.fish".source = ./fish/config.fish;
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Raul";
    userEmail = "95168615+raugl@users.noreply.github.com";
    # extraConfig.merge.conflictstyle = "diff3";

    delta = {
      enable = true;
      options = {
        syntax-theme = "tokyonight";
        natigate = true;

        plus-style = ''syntax #283b4d'';
        minus-style = ''syntax #3f2d3d'';
        plus-emph-style = ''syntax #316172'';
        minus-emph-style = ''syntax #763842'';
        plus-non-emph-style = ''syntax #283b4d'';
        minus-non-emph-style = ''syntax #3f2d3d'';
        line-numbers-zero-style = ''#3b4261'';
        line-numbers-plus-style = ''#266d6a'';
        line-numbers-minus-style = ''#b2555b'';
        plus-empty-line-marker-style = ''syntax #283b4d'';
        minus-empty-line-marker-style = ''syntax #3f2d3d'';
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      update.method = "never";

      git.paging = {
        colorArg = "always";
        pager = "${pkgs.delta}/bin/delta --dark --paging=never";
      };

      gui = {
        scrollHeight = 1;
        scrollOffMargin = 2;
        scrollOffBehavior = "margin";
        showBottomLine = false;
        nerdFontsVersion = 3;
        border = "single";

        theme = {
          activeBorderColor = ["blue" "bold"];
          selectedLineBgColor = ["#2e3c64"];
          cherryPickedCommitBgColor = ["#2e3c64"];
        };
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "builtin";
        source = "nixos";
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "terminal"
        "shell"
        "break"
        "de"
        "display"
        "wm"
        "cpu"
        {
          type = "gpu";
          driverSpecific = true;
        }
        "memory"
        "disk"
        "break"
        "colors"
      ];
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      format = pkgs.lib.concatStrings [
        "╭─ $all"
        "$line_break"
        "╰─$character"
      ];
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${pkgs.btop}/share/btop/themes/tokyo-storm.theme";
      vim_keys = true;

      update_ms = 200;
      show_uptime = false;
      clock_format = "up /uptime";
      selected_battery = "BAT0";

      proc_sorting = "cpu direct";
      cpu_single_graph = true;
      show_coretemp = false;

      disks_filter = "exclude=/boot";
      show_disks = false;
    };
  };

  programs.bat = {
    enable = true;
    config.italic-text = "always";
    config.style = "numbers";
    config.theme = "tokyonight";

    themes.tokyonight = {
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "tokyonight.nvim";
        rev = "057ef5d260c1931f1dffd0f052c685dcd14100a3";
        sha256 = "sha256-1xZhQR1BhH2eqax0swlNtnPWIEUTxSOab6sQ3Fv9WQA=";
      };
      file = "extras/sublime/tokyonight_moon.tmTheme";
    };
  };

  programs.tealdeer = {
    enable = true;

    settings = {
      style = {
        description.foreground = "green";
        command_name.foreground = "blue";
        example_code.foreground = "cyan";
        example_variable = {
          foreground = "cyan";
          underline = true;
          italic = true;
        };
      };

      display = {
        compact = false;
        use_pager = true;
      };

      updates = {
        auto_update = true;
        auto_update_interval_hours = 360;
      };
    };
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };
}
