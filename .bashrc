# /DATA/.bashrc for interactive shell configuration in Bash
# This file customizes your Bash shell environment in ZimaOS with a Solarized-inspired look and handy tools.
# Note: In ZimaOS, this might be in /DATA/.bashrc instead of ~/.bashrc due to system configuration.

# Source global definitions (if they exist)
# Loads system-wide Bash settings if /etc/bashrc exists.
if [ -f /etc/bashrc ]; then
    . /etc/bashrc  # '.' is shorthand for 'source'.
fi

##############################################################
# PATH
##############################################################

# Defines where Bash looks for commands, adding personal and system directories.
export PATH=$PATH:~/bin:/usr/bin:/bin:/usr/sbin:/sbin
# - ~/bin: Personal scripts/binaries.
# - /usr/bin, /bin: User and system commands.
# - /usr/sbin, /sbin: Admin commands (some need sudo).

##############################################################
# PROMPT (Solarized-inspired with tput)
##############################################################

# Colors using tput for a Solarized-inspired prompt.
BASE1=$(tput setaf 247)   # Light gray (#93a1a1) for user@host, visible on dark terminals.
BASE0=$(tput setaf 244)   # Light gray (#839496) for directory.
YELLOW=$(tput setaf 136)  # Yellow (#b58900) for prompt symbol and accents.
GREEN=$(tput setaf 100)   # Green (#859900) for success indicator.
RED=$(tput setaf 124)     # Red (#dc322f) for error indicator.
RESET=$(tput sgr0)        # Resets color to default.

# Dynamic prompt: Shows green ➜ if last command succeeded, red if it failed.
PS1='\[$BASE1\]\u@\h\[$RESET\]:\[$BASE0\]\w\[$RESET\] $(if [ $? -eq 0 ]; then echo "\[$GREEN\]➜"; else echo "\[$RED\]➜"; fi) \[$YELLOW\]\$\[$RESET\] '
# - \u@\h: Username@hostname.
# - \w: Current directory.
# - $(if [ $? -eq 0 ]...): Checks last command’s exit status ($?), green ➜ for success (0), red for failure.
# - \$: '$' for user, '#' for root.

##############################################################
# COLOR SUPPORT (using dircolors)
##############################################################

# Sets up colored ls output with dircolors.
eval "$(dircolors -b)"    # Loads default color database.
alias ls='ls --color=auto'  # Enables colors for ls (e.g., blue dirs, green executables).
# Tip: To customize colors further, edit ~/.dircolors (if writable) with Solarized values.

##############################################################
# HISTORY SETTINGS
##############################################################

# Configures command history.
HISTSIZE=1000             # Max commands in memory: 1000.
HISTFILESIZE=2000         # Max commands in ~/.bash_history: 2000.
HISTCONTROL=ignoreboth    # Ignores duplicates and space-prefixed commands.
shopt -s histappend       # Appends to history file instead of overwriting.

##############################################################
# COMPLETION
##############################################################

# Enables tab completion if system-wide completion script exists.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion  # Loads completion rules.
fi

##############################################################
# ALIASES
##############################################################

# Common shortcuts
alias ll='ls -la'         # Lists all files (including hidden) in long format.
alias l='ls -l'           # Shorter long listing without hidden files.
alias cls='clear'         # Clears the terminal screen.

# System monitoring
alias ttop='top -d 2 -n 30'  # Runs top with 2-second updates for 30 iterations.
alias mem='free -h'       # Shows memory usage in human-readable format (if 'free' exists).
alias cpu='top -n 1'      # Quick CPU/process snapshot (stops after 1 iteration).
alias pg='ps aux | grep -i'  # Searches processes (e.g., 'pg bash').
alias df='df -h'          # Shows disk usage in human-readable format (if 'df' exists).
alias stat='printf "Uptime: %s | Memory: %s\n" "$(uptime -p 2>/dev/null || echo unknown)" "$(free -h 2>/dev/null || echo unknown)"'  # Quick status check.

# Network tools
alias listen="sudo lsof -i -P 2>/dev/null | grep -i 'listen' || netstat -tuln 2>/dev/null"  # Lists listening ports.

# Directory navigation
alias ..='cd ..'          # Moves up one directory level.
alias ...='cd ../..'      # Moves up two directory levels.
alias downloads='cd ~/Downloads'         # Goes to ~/Downloads.
alias desktop='cd ~/Desktop'             # Goes to ~/Desktop.
# alias sites='cd /<your-directory-path/>'                              # Adjust this to your needs

# File management
alias rm='rm -i'          # Prompts for confirmation before removing files (safer).
alias size='du -h'        # Shows file/directory size in human-readable format (e.g., 'size file.txt').
alias la='ll'             # Alias for 'll' (lists all files in long format).
alias h='history | grep'  # Searches command history (e.g., 'h cd').

# Nerd stuff (playful shortcuts)
alias wtf='dmesg'         # Shows system logs.
alias rtfm='man'          # Opens manual pages.
alias visible='echo'      # Prints text.
alias invisible='cat'     # Displays file contents.
alias moar='more'         # Paginates output.
alias icanhas='mkdir'     # Creates a directory.
alias donotwant='rm'      # Removes files/directories (overridden by 'rm -i' above).
alias dowant='cp'         # Copies files.
alias gtfo='mv'           # Moves files.
alias hai='cd'            # Changes directory.
alias plz='/bin/pwd'      # Prints current directory.
alias nomz='ps aux | less'  # Lists processes, paginated.
alias nomnom='killall'    # Kills processes by name.
alias cya='reboot'        # Reboots the system.
alias kthxbai='halt'      # Shuts down the system.

# Enable autocd if available (Bash 4.0+)
# Lets you type a directory name to change to it without 'cd'.
shopt -s autocd 2>/dev/null || echo "Note: autocd not available in this Bash version"

# Welcome message with ASCII art
# Prints an ASCII "Zima OS" banner in yellow, followed by a greeting with username in light gray.
printf "\n"
printf "%s ____  __  _  _   __      __   ____ %s\n" "$YELLOW" "$RESET"
printf "%s(__  )(  )( \/ ) / _\    /  \ / ___)%s\n" "$YELLOW" "$RESET"
printf "%s / _/  )( / \/ \/    \  (  O )\___ \%s\n" "$YELLOW" "$RESET"
printf "%s(____)(__)\_)(_/\_/\_/   \__/ (____/%s\n" "$YELLOW" "$RESET"
printf "\n"  # Adds a blank line after the ASCII art for separation.
printf "%s─── Welcome to Zima OS, %s%s%s ───%s\n" "$YELLOW" "$RESET" "$BASE1" "$(whoami)" "$RESET"
printf "Date: %s | Uptime: %s\n" "$(date '+%A, %B %d, %Y')" "$(uptime -p 2>/dev/null || echo unknown)"
printf "\n"
# - ASCII art in yellow, blank line, then dashes in yellow, username in light gray, rest in default color.
