set -gx PATH $HOME/.cargo/bin $PATH
if status --is-interactive
    function update_starship
        set -l bg (jq -r '.special.background' ~/.cache/wal/colors.json)
        set -l fg (jq -r '.special.foreground' ~/.cache/wal/colors.json)

        # Replace the format in starship.toml
        sed -i "s/bg:#[0-9a-fA-F]\{6\}/bg:$bg/g" ~/.config/starship.toml
        sed -i "s/fg:#[0-9a-fA-F]\{6\}/fg:$fg/g" ~/.config/starship.toml
    end
    set -gx COLORTERM truecolor
    set -gx TERM xterm-256color
    update_starship # prompt

    export MANPAGER='nvim +Man!'
    # remove greeting
    set -g fish_greeting ""

    # Get the terminal width
    set width (tput cols)

    # Check if the width is less than 82
    if test $width -lt 82
        kingler random -i -u --no-title
    else
        kingler random -i -u --no-title
    end

    # yazicd
    function yazicd
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function remove
        set orphaned (pacman -Qdtq)

        if test -n "$orphaned"
            echo $orphaned | sudo pacman -Rns -
        else
            echo "No package to remove."
        end
    end
    #-------------------------------------------------------
    # BETTER LS
    #-------------------------------------------------------
    function ls
        eza --icons --group-directories-first --sort=extension $argv
    end

    #-------------------------------------------------------
    # AUR HELPER
    #-------------------------------------------------------
    function yay
        paru $argv
    end

    #-------------------------------------------------------
    # FOR ARTIX UPDATE
    #-------------------------------------------------------
    function update
        paru -Syu $argv
    end

    function UPDATE
        paru -Syu --disable-download-timeout $argv
    end

    function :3
        uwu-h update $argv
    end

    #-------------------------------------------------------
    # MY AUR HELPER
    #-------------------------------------------------------
    function uwu
        uwu-h $argv
    end

    function owo
        uwu-h install $argv
    end

    function TwT
        uwu-h remove $argv
    end

    #-------------------------------------------------------
    # SERVER DB
    #-------------------------------------------------------
    function execmariadb
        sudo mariadbd-safe --nowatch >/dev/null 2>&1 && echo SUCCESS || echo FAILURE
    end

    #-------------------------------------------------------
    # TO DISPLAY IMAGES IN TERMINAL
    #-------------------------------------------------------
    function k
        kitty +kitten icat $argv
    end

    #-------------------------------------------------------
    # PERSONAL USE FOR NOTES AND THESIS
    #-------------------------------------------------------
    function appunti
        cd ~/Repository/LaTeX
        nvim
    end

    function tesi
        cd ~/Repository/Tesi
        nvim
    end

    #-------------------------------------------------------
    # SHOW THE DIRECTORY OF MY WALLPAPERS
    #-------------------------------------------------------
    function ew
        ls -l ~/Immagini/Wallpapers
    end

    #-------------------------------------------------------
    # BETTER CAT
    #-------------------------------------------------------
    function cat
        bat $argv
    end

    #-------------------------------------------------------
    # MIKU MIKU YOU CAN CALL ME MIKU
    #-------------------------------------------------------
    function mikufetch
        uwufetch --image /home/$USER/Immagini/Wallpapers/Vocaloid/39.png $argv
    end

    function miku
        fastfetch $argv
    end

    #-------------------------------------------------------
    # MATLAB
    #-------------------------------------------------------
    function matlab
        ./.MATLAB/bin/matlab $argv
    end

    #-------------------------------------------------------
    # ZATHURA
    #-------------------------------------------------------
    function zathura
        zathura-pywal $argv
    end

    #-------------------------------------------------------
    # ZOXIDE
    #-------------------------------------------------------

    zoxide init fish | source

    alias cd='z'

    #-------------------------------------------------------
    # YAZI
    #-------------------------------------------------------
    bind \co yazicd
    bind \ce yazicd

    #-------------------------------------------------------
    # METAMUSIC
    #-------------------------------------------------------
    bind \cx metamusic

    #-------------------------------------------------------
    # GIT
    #-------------------------------------------------------
    bind \cg gitui
    bind \ca gitui

    #-------------------------------------------------------
    # BOTTOM
    #-------------------------------------------------------
    bind \cq btm

    #-------------------------------------------------------
    # TREE
    #-------------------------------------------------------
    bind \ct 'tree -L 2'

    #-------------------------------------------------------
    # LS
    #-------------------------------------------------------
    bind \cw 'eza -l'

    #-------------------------------------------------------
    # MAKE ALL
    #-------------------------------------------------------
    bind \cz 'make all'

    #-------------------------------------------------------
    # DISK USAGE
    #-------------------------------------------------------
    bind \cd dysk

    #-------------------------------------------------------
    # UPDATE
    #-------------------------------------------------------
    bind \cu update

    # Load Fisher for managing plugins
    set -g fish_plugins jethrokuan/z jethrokuan/fzf jethrokuan/fzf-tab fzf-tab/fish-fzf

    # Ensure Fisher is loaded before adding plugins
    if not functions -q fisher
        set -g fish_plugins jethrokuan/z
        fisher install
    end

end
