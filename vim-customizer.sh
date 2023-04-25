#!/bin/bash

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

    # Edit the settings here
    printf "\nWhat settings would you like to edit? Please type the number here (hit enter to exit): "
    read option
    if [ ! -z "$option" ]; then
        case "$option" in
        1) # Edit the tabstop settings
            printf "\nPlease enter your desired tabstop: "
            read val
            if [ $ts != 0 ]; then
                sed -E -i "s/^set tabstop=$tabstop$/set tabstop=$val/" .vimrc
            else
                echo "" >>.vimrc
                echo "set tabstop=$val" >>.vimrc
            fi
            printf "Tabstop changed to $val!\n"
            ;;
        2) # Edit the shiftwidth settings
            printf "\nPlease enter your desired shiftwidth: "
            read val
            if [ $sw != 0 ]; then
                sed -E -i "s/^set shiftwidth=$shiftwidth$/set shiftwidth=$val/" .vimrc
            else
                echo "" >>.vimrc
                echo "set shiftwidth=$val" >>.vimrc
            fi
            printf "Shiftwidth changed to $val!\n"
            ;;
        3) # Edit the expandtab setting
            printf "\nWould you like Expandtab on? (Y/N): "
            read opt
            case "$opt" in
            Y)
                if [ $expandtab == 0 ]; then
                    echo "" >>.vimrc
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
        *) # Invalid options
            printf "\nInvalid option. Please choose a number 1-3!\n"
            ;;
        esac
    fi
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
            echo "syntax on" >>~/.vimrc
            ;;
        2)
            # Enable line numbers
            printf "Enabling line numbers...\n"
            echo "set number" >>~/.vimrc
            ;;
        3)
            # Enable cursor line
            printf "Enabling cursor line...\n"
            echo "set cursorline" >>~/.vimrc
            ;;
        4)
            # Enable cursor column
            printf "Enabling cursor column...\n"
            echo "set cursorcolumn" >>~/.vimrc
            ;;
        5)
            # Disable line wrapping
            printf "Disabling line wrapping...\n"
            echo "set nowrap" >>~/.vimrc
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
    # Print welcome menu
    printf "\nWelcome to the LP vim customizer! Here, we've set up easy ways to change your vim settings, especially for beginners! What would you like to do?\n"
    printf "\t[1] Edit General Settings\n\t[2] Edit Tab Settings\n\t[<Enter> or CTRL+D] to Quit\n"
    read option

    # Loop, allowing users to continue to edit settings as they like
    while [ ! -z "$option" ]; do
        case "$option" in
        1)
            general_settings
            ;;
        2)
            tab_settings
            ;;
        *)
            printf "Invalid Option.\n"
            ;;
        esac
        printf "\nWelcome to the LP vim customizer! Here, we've set up easy ways to change your vim settings, especially for beginners! What would you like to do?\n"
        printf "\t[1] Edit General Settings\n\t[2] Edit Tab Settings\n\t[<Enter> or CTRL+D] to Quit\n"
        read option
    done

    # Exit statement
    printf "Thanks for using the LP vim customizer!\n"
}

# Function that checks for the existence of a .vimrc file. If nonexistent, it prompts the user to either navigate to the desired directory or to create the file.
function start() {
    if [ ! -f ".vimrc" ]; then
        # No .vimrc file
        printf "\nYou currently do not have a .vimrc file in this folder. Would you like to [1] Create a .vimrc file, or [2] Exit the program and navigate to the folder with a .vimrc file? "
        read option
        while [ ! -z "$option" ]; do
            case "$option" in
            1) # Create a new .vimrc file
                touch .vimrc
                menu
                break
                ;;
            2) # User chooses to navigate to a proper folder
                printf "\nShutting down...\n"
                break
                ;;
            *) # Bad option, try again
                printf "\nInvalid Option.\n"
                printf "\nYou currently do not have a .vimrc file in this folder. Would you like to [1] Create a .vimrc file, or [2] Exit the program and navigate to the folder with a .vimrc file? "
                read option
                ;;
            esac
        done
    else
        # .vimrc file found, go to the main menu
        menu
    fi
}

start
