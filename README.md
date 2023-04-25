# LP VIM CUSTOMIZER
Welcome to Lucas and Pranav's vim customizer!
We created this tool because we wanted to make changing basic vim settings easier for people who were newer to vim, and hopefully lessen the learning curve for new users.

## Startup
Make sure to run vim-customizer.sh in your home folder, or whatever other folder your vim path points to for your .vimrc file.
If the script is not run in the proper folder (or the .vimrc file does not exist), the script will prompt you to either close it down and navigate to a desired folder, or to simply create a .vimrc file.

## Using the tool


### General Settings
We've put together a list of general settings that would be helpful to newcomers.
Here's a list of the different ones we have available!
1. Syntax highlighting - vim is quite dull by default (standard black and white), but with syntax highlighting on, users can have a more colorful experience while using vim.
2. Line numbers - While vim lists the line number and current character in the bottom right of the screen, sometimes it's also useful to have the line number listed directly to the left of the code.
This setting enables it!
3. Cursor line - This setting highlights the entire line that the cursor is currently pointing to, allowing the user to quickly identify the line that they are working on.
4. Cursor column - Similar to cursor line, this setting hightlights the entire column that the cursor is currently pointing to.
5. Line wrapping - Disabling line wrapping will allow code to directly run off the screen, rather than wrapping it back.


### Tab Settings
Here, users are able to modify tab-based settings, an important early modification for vim users.
1. Tabstop - a numerical value representing how many characters wide a '\t' character is.
2. Shiftwidth - a numerical value representing how many characters wide a left shift or a right shift is.
3. Expandtab - Whether or not a '\t' character actually lives in the file. If expandtab is on, every time tab is hit, the tab character is automatically converted to whitespace characters. If this setting on, hitting backspace after hitting tab will delete one whitespace, if it is off, backspace will delete one tab character.

