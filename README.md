# ZimaOS Bash Configuration

This repository contains a customized `.bashrc` file designed for the ZimaOS operating system, an immutable, minimal Linux-based environment. It enhances the Bash shell with a Solarized-inspired aesthetic, practical aliases, and a welcoming ASCII art banner. Developed with care, this configuration balances functionality, convenience, and visual appeal while respecting ZimaOS’s constraints (e.g., no `xclip`, `pbcopy`, or `git` by default).

## Features

### Prompt

* **Dynamic Solarized Prompt**: Displays `username@hostname:directory ➜ $` with:
  * Username and hostname in light gray (`tput setaf 247`, Solarized Base1).
  * Directory in a slightly darker gray (`tput setaf 244`, Solarized Base0).
  * A dynamic arrow (`➜`) in green (`tput setaf 100`) for command success or red (`tput setaf 124`) for failure.
  * Prompt symbol (`$` or `#`) in yellow (`tput setaf 136`).
* **Example**: `<username>@<yourhostname>:~/Sites ➜ $` (green arrow after a successful `ls`).

### Welcome Message

* **ASCII Art**: A stylish "Zima OS" banner in yellow, followed by a break for readability:
```
 ____  __  _  _   __      __   ____ 
(__  )(  )( \/ ) / _\    /  \ / ___)
 / _/  )( / \/ \/    \  (  O )\___ \
(____)(__)\_)(_/\_/\_/   \__/ (____/
```
* **Greeting**: `─── Welcome to Zima OS, username ───` with yellow dashes and the username in light gray.
* **Info**: Date (e.g., "Thursday, April 03, 2040") and uptime (e.g., "up 2 hours, 15 minutes") in default terminal color.

### Color Support

* **Colored `ls`**: Uses `dircolors` to enable colored output for `ls` (e.g., blue directories, green executables).
* **Customization Tip**: Edit `~/.dircolors` (if writable) for Solarized-specific colors.

### History Settings

* **Command History**: Stores up to 1000 commands in memory (`HISTSIZE`) and 2000 in `~/.bash_history` (`HISTFILESIZE`).
* **Behavior**: Ignores duplicates and space-prefixed commands (`ignoreboth`), appends to history file (`histappend`).

### Tab Completion

* **Optional Completion**: Sources `/etc/bash_completion` if available for enhanced tab completion (e.g., command options).

### Aliases

#### Common Shortcuts

* `ll`: `ls -la` — Lists all files (including hidden) in long format.
* `l`: `ls -l` — Long listing without hidden files.
* `cls`: `clear` — Clears the terminal screen.

#### System Monitoring

* `ttop`: `top -d 2 -n 30` — Runs `top` with 2-second updates for 30 iterations.
* `mem`: `free -h` — Shows memory usage (if `free` exists).
* `cpu`: `top -n 1` — Quick CPU/process snapshot.
* `pg`: `ps aux | grep -i` — Searches processes (e.g., `pg bash`).
* `df`: `df -h` — Shows disk usage in human-readable format (if `df` exists).
* `stat`: Prints uptime and memory status (e.g., "Uptime: up 2 hours | Memory: ...").

#### Network Tools

* `listen`: Lists listening ports using `lsof` or `netstat` (falls back if one isn’t available).

#### Directory Navigation

* `..`: `cd ..` — Moves up one directory level.
* `...`: `cd ../..` — Moves up two directory levels.

#### File Management

* `rm`: `rm -i` — Prompts before removing files for safety.
* `size`: `du -h` — Shows file/directory size (e.g., `size file.txt`).
* `la`: Alias for `ll`.
* `h`: `history | grep` — Searches command history (e.g., `h cd`).

#### Nerd Stuff (Playful Aliases)

* `wtf`: `dmesg` — System logs.
* `rtfm`: `man` — Manual pages.
* `visible`: `echo` — Prints text.
* `invisible`: `cat` — Displays file contents.
* `moar`: `more` — Paginates output.
* `icanhas`: `mkdir` — Creates directories.
* `donotwant`: `rm` — Removes files (with `rm -i` prompt).
* `dowant`: `cp` — Copies files.
* `gtfo`: `mv` — Moves files.
* `hai`: `cd` — Changes directory.
* `plz`: `/bin/pwd` — Prints current directory.
* `nomz`: `ps aux | less` — Lists processes with pagination.
* `nomnom`: `killall` — Kills processes by name.
* `cya`: `reboot` — Reboots the system.
* `kthxbai`: `halt` — Shuts down the system.

### Autocd

* **Feature**: Enables changing directories by typing their names (e.g., `Downloads` instead of `cd Downloads`), if Bash 4.0+ supports it. Falls back with a note if unavailable.

## Installation

### Files
- **`.bashrc`**: The main configuration file with prompt, aliases, and welcome message.
- **`.bash_profile`**: A login shell script that sources `.bashrc` automatically on SSH login, ensuring the configuration loads without manual intervention.

### Steps
1. **Download Both Files**:
 * Since ZimaOS lacks `git`, use `curl` or `wget` to fetch from the repository:
   ```bash
   sudo curl -o /DATA/.bashrc https://raw.githubusercontent.com/axelquack/dotfiles-zimaos/main/.bashrc
   sudo curl -o /DATA/.bash_profile https://raw.githubusercontent.com/axelquack/dotfiles-zimaos/main/.bash_profile
   ```
   Or with `wget`:
   ```bash
   sudo wget -O /DATA/.bashrc https://raw.githubusercontent.com/axelquack/dotfiles-zimaos/main/.bashrc
   sudo wget -O /DATA/.bash_profile https://raw.githubusercontent.com/axelquack/dotfiles-zimaos/main/.bash_profile
   ```
 * These commands place the files in `/DATA/`, the ZimaOS-specific location.

2. **Set Permissions**:
 * Ensure both files are readable:
   ```bash
   sudo chmod 644 /DATA/.bashrc /DATA/.bash_profile
   ```

3. **Source It**:
 - Apply the configuration manually for the current session:
   ```bash
   source /DATA/.bashrc
   ```
 - On subsequent SSH logins, `.bash_profile` will autoload `.bashrc`.

## Usage

* **Prompt**: Run commands and watch the `➜` turn green (success) or red (failure).
* **Welcome**: Open a terminal to see the "Zima OS" banner and greeting.
* **Aliases**: Use shortcuts like `ll`, `ttop`, `df`, `stat`, or `nomz` for quick tasks.
* **Navigation**: Try `..`, `downloads`, or `sites` to move around.
* **Safety**: `rm` prompts for confirmation (e.g., `donotwant file.txt` asks before deleting).

## Customization

* **Colors**: Adjust `tput setaf` values (e.g., `136` for yellow) in the `# PROMPT` section.
* **Aliases**: Add or modify aliases under `# ALIASES` to fit your workflow.
* **Welcome**: Tweak the ASCII art or message in the `# Welcome message` section.

## Requirements

* **ZimaOS**: Optimized for this immutable OS, but works on (probably) any Bash-compatible Linux system.
* **Tools**: Assumes `tput`, `dircolors`, `top`, `free`, `df`, `uptime`, `ps`, `grep`, `ls`, etc., are available. Fallbacks (e.g., `echo unknown`) handle missing tools gracefully.

## Contributing

Feel free to fork this repository, adapt it, and submit pull requests! Suggestions for new aliases, better ASCII art, or ZimaOS-specific tweaks are welcome.

## License
This work is licensed under a [Creative Commons Zero 1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/).

* **You are free to**: Use, copy, modify, and distribute this work for any purpose, including commercial use, without any conditions or attribution required.
* **No Rights Reserved**: The author has waived all copyright and related rights to the fullest extent allowed by law, effectively placing this work in the public domain.
