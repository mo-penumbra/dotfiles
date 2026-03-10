# Dotfiles Template

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Use this template to create your own dotfiles repo.

## Getting Started

1. Click **"Use this template"** on GitHub to create your own repo
2. Clone your new repo: `git clone <your-repo-url> ~/dotfiles`
3. **Personalize** the placeholder values (see below)
4. Run `cd ~/dotfiles && ./install.sh`

If you already have dotfiles you want to keep, `--adopt` will move your existing files into the repo (replacing the template versions) and create symlinks in their place. Your configs are preserved — the repo becomes the source of truth with *your* content. After running, review the changes with `git diff` and commit to save your adopted configs.

## Personalize These Files

After creating your repo from this template, replace placeholder values:

| File | Placeholders |
|------|-------------|
| `git/.gitconfig` | `<YOUR_NAME>`, `<YOUR_EMAIL>` |
| `ssh/.ssh/config` | `<YOUR_EMAIL>` |
| `shell/.zshrc` | Uncomment and edit the `myb()` branch prefix function with `<YOUR_INITIALS>` |

## Template Files (secrets)

These `.template` files have placeholder API keys. Copy and fill in on each machine:

```bash
cp claude/.claude/claude_desktop_config.json.template ~/.claude/claude_desktop_config.json
# Then edit each file to add your actual API keys
```

## Packages

| Package | Files | Description |
|---------|-------|-------------|
| `shell` | `.zshrc`, `.bashrc`, `.profile`, `.p10k.zsh` | Shell configuration and prompt theme |
| `git` | `.gitconfig`, `.config/gh/config.yml` | Git aliases, user config, GitHub CLI |
| `tmux` | `.tmux.conf` | Terminal multiplexer settings |
| `ssh` | `.ssh/config` | SSH host configuration (no keys) |
| `claude` | `.claude/CLAUDE.md`, `.claude/settings.json` | Claude Code global preferences |
| `codex` | `.codex/config.toml` | OpenAI Codex CLI config |
| `jupyter` | `.jupyter/jupyter_server_config.py` | Jupyter default kernel |
| `tools` | `.config/htop/htoprc` | htop display settings |

## Managing Packages

```bash
cd ~/dotfiles

# Re-stow a single package after editing
stow --restow shell

# Add a new config file: put it in the right package dir, then restow
cp ~/.some_config tools/
stow --restow tools

# Remove symlinks for a package
stow --delete shell
```

## Prerequisites

- [oh-my-zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [GitHub CLI (gh)](https://cli.github.com/)
- [uv](https://docs.astral.sh/uv/)
