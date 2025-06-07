if status is-interactive
    function fish_greeting
        fastfetch
    end

    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block

    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx PAGER "bat --number"
    set -gx MANPAGER "less -R"
    set -gx DELTA_PAGER "less -R"

    alias cd="z"
    alias vi="nvim"
    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias ls="eza --icons=always --group-directories-first --all"
    alias ll="eza --icons=always --group-directories-first --all --long --header"
    alias hm-switch="home-manager switch --flake ~/.dotfiles --impure"
    alias hm-dryrun="home-manager build --flake ~/.dotfiles --impure --dry-run"

    # Color theme for man pages
    set -gx MANROFFOPT "-c"
    set -gx LESS_TERMCAP_mb $(tput bold; tput setaf 4)                       # Start blinking
    set -gx LESS_TERMCAP_md $(tput bold; tput setaf 4)                       # Start bold
    set -gx LESS_TERMCAP_so $(tput bold; tput setaf 2)                       # Start stand out
    set -gx LESS_TERMCAP_us $(tput bold; tput smul; tput sitm; tput setaf 6) # Start underline
    set -gx LESS_TERMCAP_se $(tput rmso; tput sgr0)                          # End stand out
    set -gx LESS_TERMCAP_me $(tput sgr0)                                     # End bold, blinking, standout, underline
    set -gx LESS_TERMCAP_ue $(tput sgr0)                                     # End underline

    fish_add_path ~/.local/bin
    function help
        command $argv --help | bat --language help
    end

    direnv hook fish | source
    zoxide init fish | source
    starship init fish | source
end
