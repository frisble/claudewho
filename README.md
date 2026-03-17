```
   ____ _        _   _   _ ____  _______        ___   _  ___
  / ___| |      / \ | | | |  _ \| ____\ \      / / | | |/ _ \
 | |   | |     / _ \| | | | | | |  _|  \ \ /\ / /| |_| | | | |
 | |___| |___ / ___ \ |_| | |_| | |___  \ V  V / |  _  | |_| |
  \____|_____/_/   \_\___/|____/|_____|  \_/\_/  |_| |_|\___/
```

# claudewho

Manage multiple Claude Code account configurations easily. Switch between work and personal accounts, or maintain separate configurations for different projects.

## Installation

### Homebrew (recommended)

```bash
brew install frisble/tap/claudewho
```

Or:

```bash
brew tap frisble/tap
brew install claudewho
```

### Manual

```bash
git clone https://github.com/frisble/claudewho.git
cd claudewho
chmod +x bin/claudewho
sudo ln -s "$(pwd)/bin/claudewho" /usr/local/bin/claudewho
```

## Setup

Add this line to your `~/.zshrc` (or `~/.bashrc` for Bash):

```bash
eval "$(claudewho shell-init)"
```

Then reload your shell:

```bash
source ~/.zshrc
```

## Usage

### Create accounts

```bash
claudewho add work
claudewho add personal
claudewho add client-project
```

### List accounts

```bash
claudewho list
```

Output:
```
Configured Claude accounts:

  work                 ~/.claudewho-work              (authenticated)
  personal             ~/.claudewho-personal          (not authenticated)
  client-project       ~/.claudewho-client-project    (authenticated)

Use claudewho-<name> or claudewho use <name> to launch.
```

### Launch Claude with an account

After running `source ~/.zshrc`, you can use:

```bash
# Using the alias (recommended)
claudewho-work
claudewho-personal

# Or using the command
claudewho use work
```

### Remove an account

```bash
claudewho remove personal
```

This will prompt for confirmation before deleting the account directory.

## Commands

| Command | Description |
|---------|-------------|
| `list` | List all configured accounts |
| `add <name>` | Create a new account configuration |
| `remove <name>` | Remove an account (with confirmation) |
| `use <name>` | Switch to the specified account |
| `ide-setup` | Configure IDE integration (VSCode) |
| `shell-init` | Print shell aliases for sourcing |
| `version` | Show version information |
| `help` | Show help message |

## IDE Integration (VSCode)

The Claude Code IDE extensions bundle their own CLI and don't respect `CLAUDE_CONFIG_DIR` by default. claudewho provides wrapper scripts that work with the extension's `claudeProcessWrapper` setting.

### Setup

```bash
claudewho ide-setup
```

This creates the necessary wrapper scripts and prints configuration instructions.

### Option 1: Follow current account

All IDE windows share whichever account is active via `claudewho use <name>`.

Add to your VSCode settings.json (`Cmd+Shift+P` > "Open Settings (JSON)"):

```json
"claude-code.claudeProcessWrapper": "~/.local/bin/claudewho-ide"
```

### Option 2: Per-workspace account (parallel)

Different workspaces can use different accounts simultaneously.

Add to your workspace's `.vscode/settings.json`:

```json
"claude-code.claudeProcessWrapper": "~/.local/bin/claudewho-ide-work"
```

To see all available per-account wrappers:

```bash
claudewho ide-setup
```

Or get the config for a specific account:

```bash
claudewho ide-setup --account work
```

## How it works

- Each account is stored in `~/.claudewho-<name>/`
- Account names are tracked in `~/.claudewho.conf`
- The `shell-init` command generates aliases like `claudewho-work` that set `CLAUDE_CONFIG_DIR` before launching Claude
- Your original `~/.claude` directory is never modified

## Requirements

- Claude Code CLI installed (`npm install -g @anthropic-ai/claude-code`)
- Bash 4.0+ or Zsh
- macOS or Linux

## Notes

- Each account requires a separate Anthropic account (different email)
- Each account has its own usage limits
- Check [Anthropic's terms of service](https://www.anthropic.com/terms) to ensure compliance

## License

MIT
