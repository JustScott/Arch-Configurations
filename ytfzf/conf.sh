#Variables {{{
    ytdl_pref="bestvideo[height<=480][fps<=30]+bestaudio"
##}}}

##Functions {{{
external_menu () {
    if which bemenu &>/dev/null; then
        bemenu -l 15 --fn "monospace 16" -w -p "YT || Odysee" "$1"
    fi
}
#}}}
