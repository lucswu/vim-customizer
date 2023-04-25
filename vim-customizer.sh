#!/bin/bash

function color_scheme() {
    printf "WIP color_scheme!"
}

function tab_settings() {
    printf "WIP tab_settings!"
}

function general_settings() {
    printf "WIP general_settings!"
    # https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
}

# Standard Menu
function menu() {
    printf "\nWelcome to the LP vim customizer! Here, we've set up easy ways to change your vim settings, especially for beginners! What would you like to do?\n"
    printf "\t[1] Edit Color Scheme\n\t[2] Edit tab settings\n\t[3] General Settings (line numbers, syntax, etc.)\n\t[<Enter> or CTRL+D] to Quit\n"
    read option
    while [ ! -z "$option" ]; do
        case "$option" in
        1)
            color_scheme
            ;;
        2)
            tab_settings
            ;;
        3)
            general_settings
            ;;
        *)
            printf "Invalid Option.\n"
            ;;
        esac
        printf "\nWelcome to the LP vim customizer! Here, we've set up easy ways to change your vim settings, especially for beginners! What would you like to do?\n"
        printf "\t[1] Edit Color Scheme\n\t[2] Edit tab settings\n\t[3] General Settings (line numbers, syntax, etc.)\n\t[<Enter> or CTRL+D] to Quit\n"
        read option
    done
    printf "Thanks for using the LP vim customizer!\n"
}

menu
