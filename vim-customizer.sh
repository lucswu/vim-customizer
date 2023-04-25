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
  printf "Welcome to the General Settings menu!\n"

  # List all the possible settings that the user can modify
  printf "Please select a setting to modify:\n"
  printf "\t[1] Enable syntax highlighting\n"
  printf "\t[2] Enable line numbers\n"
  printf "\t[3] Enable cursor line\n"
  printf "\t[4] Enable cursor column\n"
  printf "\t[5] Disable line wrapping\n"
  printf "\t[<Enter> or CTRL+D] to Quit\n"

  # Read the user's choice
  read choice

  # Process the user's choice
  while [ ! -z "$choice" ]; do
    case "$choice" in
      1)
        # Enable syntax highlighting
        printf "Enabling syntax highlighting...\n"
        echo "syntax on" >> ~/.vimrc
        ;;
      2)
        # Enable line numbers
        printf "Enabling line numbers...\n"
        echo "set number" >> ~/.vimrc
        ;;
      3)
        # Enable cursor line
        printf "Enabling cursor line...\n"
        echo "set cursorline" >> ~/.vimrc
        ;;
      4)
        # Enable cursor column
        printf "Enabling cursor column...\n"
        echo "set cursorcolumn" >> ~/.vimrc
        ;;
      5)
        # Disable line wrapping
        printf "Disabling line wrapping...\n"
        echo "set nowrap" >> ~/.vimrc
        ;;
      *)
        # Invalid option
        printf "Invalid Option.\n"
        ;;
    esac

    # Prompt the user for the next choice
    printf "\nPlease select a setting to modify:\n"
    printf "\t[1] Enable syntax highlighting\n"
    printf "\t[2] Enable line numbers\n"
    printf "\t[3] Enable cursor line\n"
    printf "\t[4] Enable cursor column\n"
    printf "\t[5] Disable line wrapping\n"
    printf "\t[<Enter> or CTRL+D] to Quit\n"
    read choice
  done

  printf "\nFinished modifying General Settings.\n"
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
