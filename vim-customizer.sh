#!/bin/bash

function color_scheme() {
    printf "WIP color_scheme!"
}

function tab_settings() {
    # Introduction
    printf "\nWelcome to the tab settings editor. Here, you can edit your tab sizing, whether or not you use the tab character, and your shiftwidth."

    # Read in information
    ts=$(grep -E "^set tabstop=" .vimrc | wc -l)
    tabstop=8
    if [ $ts != 0 ]; then
        tabstop=$(grep -E "^set tabstop=" .vimrc | sed -E "s/^set tabstop=//")
    fi
    sw=$(grep -E "^set shiftwidth=" .vimrc | wc -l)
    shiftwidth=8
    if [ $sw != 0 ]; then
        shiftwidth=$(grep -E "^set shiftwidth=" .vimrc | sed -E "s/^set shiftwidth=//")
    fi
    expandtab=$(grep -E "^set expandtab$" .vimrc | wc -l)

    # Print current settings
    printf "\nHere are your current settings:\n"
    printf "\t1) Tabstop: $tabstop\n"
    printf "\t2) Shiftwidth: $shiftwidth\n"
    if [ $expandtab == 0 ]; then
        printf "\t3) Expandtab: Off"
    else
        printf "\t3) Expandtab: On"
    fi

    printf "\nWhat settings would you like to edit? Please type the number here (hit enter to exit): "
    read option
    while [ ! -z "$option" ]; do
        case "$option" in
        1)
            printf "\nPlease enter your desired tabstop: "
            read val
            sed -E -i "s/^set tabstop=$tabstop$/set tabstop=$val/" .vimrc
            printf "Tabstop changed to $val!\n"
            ;;
        2)
            printf "\nPlease enter your desired shiftwidth: "
            read val
            sed -E -i "s/^set tabstop=$shiftwidth$/set tabstop=$val/" .vimrc
            printf "Shiftwidth changed to $val!\n"
            ;;
        3)
            printf "\nWould you like Expandtab on? (Y/N): "
            read opt
            case "$opt" in
            Y)
                if [ $expandtab == 0 ]; then
                    echo "set expandtab" >>.vimrc
                fi
                printf "\nExpandtab is now on."
                ;;
            N)
                sed -E -i "s/^set expandtab$//" .vimrc
                printf "\nExpandtab is now off."
                ;;
            *)
                printf "\nInvalid option. Please type either \"Y\" or \"N\".\n"
                ;;
            esac
            ;;
        *)
            printf "\nInvalid option. Please choose a number 1-3!\n"
            ;;
        esac
        printf "\nWhat settings would you like to edit? Please type the number here (hit enter to exit): "
        read option
    done
}

function general_settings() {
    printf "WIP general_settings!"
    # https://www.freecodecamp.org/news/vimrc-configuration-guide-customize-your-vim-editor/
}

# Standard Menu
function menu() {
    printf "\nWelcome to the LP vim customizer! Here, we've set up easy ways to change your vim settings, especially for beginners! What would you like to do?\n"
    printf "\t[1] Edit Color Scheme\n\t[2] Edit Tab Settings\n\t[3] General Settings (line numbers, syntax, etc.)\n\t[<Enter> or CTRL+D] to Quit\n"
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
        printf "\t[1] Edit Color Scheme\n\t[2] Edit Tab Settings\n\t[3] General Settings (line numbers, syntax, etc.)\n\t[<Enter> or CTRL+D] to Quit\n"
        read option
    done
    printf "Thanks for using the LP vim customizer!\n"
}

function start() {
    if [ ! -f ".vimrc" ]; then
        printf "\nYou currently do not have a .vimrc file in this folder. Would you like to [1] Create a .vimrc file, or [2] Exit the program and navigate to the folder with a .vimrc file? "
        read option
        while [ ! -z "$option" ]; do
            case "$option" in
            1)
                touch .vimrc
                menu
                break
                ;;
            2)
                printf "\nShutting down...\n"
                break
                ;;
            *)
                printf "\nInvalid Option.\n"
                printf "\nYou currently do not have a .vimrc file in this folder. Would you like to [1] Create a .vimrc file, or [2] Exit the program and navigate to the folder with a .vimrc file? "
                read option
                ;;
            esac
        done
    else
        menu
    fi
}

start
