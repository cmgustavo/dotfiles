# Dotfiles

Personal configuration files (*dotfiles*) for macOS, tailored for daily development (especially JavaScript/TypeScript, React, and React Native projects) and a fast terminal-centric workflow.

---

## Supported Applications & Tools

| Application / Tool | Repo Path | Symlink Destination | Main Purpose |
| :--- | :--- | :--- | :--- |
| **Neovim** ([LazyVim](https://www.lazyvim.org/)) | `nvim/` | `~/.config/nvim` | Primary modern editor with LSP, Treesitter, Prettier, TypeScript, GitHub Copilot, and Tmux navigation. |
| **Vim** | `vimrc` | `~/.vimrc` | Classic Vim setup with `vim-plug`, FZF, NERDTree, ALE (ESLint/Prettier), Fugitive, Gruvbox, and `vim-claude-code`. |
| **Spacemacs (Emacs)** | `spacemacs` | `~/.spacemacs` | Emacs distribution with Vim (*Evil*) keybindings, LSP for JS/TS/React, ESLint, Prettier on save, Helm, Magit, and Treemacs. |
| **Tmux** | `tmux.conf` | `~/.tmux.conf` | Terminal multiplexer with `C-a` prefix, *Catppuccin Mocha High Contrast* theme, Vim/Neovim integration, and a Claude CLI popup. |
| **Lazygit** | `lazygit/config.yml` | `~/Library/Application Support/lazygit/config.yml` | Terminal UI for Git with *Catppuccin Mocha* theme, Nerd Font icons, Neovim file editing, and custom rebase commands. |
| **EditorConfig** | `editorconfig` | `~/.editorconfig` | Global formatting rules (LF line endings, trim trailing whitespace, 2-space indent for JS/TS/HTML/CSS/JSON, and tabs for `Makefile`). |
| **JetBrains IDEs (IdeaVim)** | `ideavimrc` | `~/.ideavimrc` *(manual link)* | Vim emulation and `<Space>` leader keybindings for IntelliJ IDEA, WebStorm, Android Studio, PyCharm, etc. |
| **GnuCash** | `gnucash.css` | *(Used in GnuCash templates)* | Custom CSS stylesheet for formatting and printing invoices in GnuCash. |

### Automatically Installed Homebrew Packages

Running `install.sh` installs the following packages if they are not already present on the system:

- **CLI Formulae:**
  - `neovim`: Primary text editor.
  - `ripgrep` (`rg`): Fast text search tool used by Neovim pickers, FZF, and Spacemacs.
  - `fzf`: Command-line fuzzy finder (used in terminal and Vim).
  - `node`: JavaScript runtime required by LSP servers, Prettier, ESLint, and GitHub Copilot.
  - `bat`: `cat` clone with syntax highlighting (used for FZF previews).
  - `lazygit`: Interactive terminal UI for Git.
  - `git-delta`: Syntax-highlighting pager for Git diffs.
  - `gh`: Official GitHub CLI.
- **GUI Apps & Fonts (Casks):**
  - `iterm2`: macOS terminal emulator.
  - `font-jetbrains-mono-nerd-font`: Nerd Font patched typeface used across iTerm2 and editors.

---

## Features by Component

### 1. Neovim (`nvim/`)
Built on **LazyVim** with automatic `lazy.nvim` bootstrapping:
- **Enabled LazyVim Extras (`nvim/lazyvim.json`):**
  - Full **TypeScript** support (`lazyvim.plugins.extras.lang.typescript`).
  - **Prettier** formatting (`lazyvim.plugins.extras.formatting.prettier`).
  - AI assistance via **GitHub Copilot** and **Copilot Chat** (`ai.copilot`, `ai.copilot-chat`).
  - Enhanced yank/paste history with **Yanky** (`coding.yanky`).
- **Custom Options (`nvim/lua/config/options.lua`):**
  - Soft line wrapping enabled (`wrap`, `linebreak`, `breakindent`) with `↳ ` prefix indicator.
  - 2-space indentation (`expandtab`, `shiftwidth = 2`).
- **Custom Keymaps & Plugins:**
  - `<Leader><Tab>`: Quickly switch to the alternate buffer (`<C-^>`).
  - `vim-tmux-navigator` (`nvim/lua/plugins/tmux.lua`): Seamless navigation between Neovim splits and Tmux panes using `Ctrl-h`, `Ctrl-j`, `Ctrl-k`, and `Ctrl-l`.

### 2. Vim (`vimrc`)
Self-contained configuration that automatically installs **vim-plug** on first launch if missing:
- **Included Plugins:** `fzf` & `fzf.vim`, `nerdtree`, `bufexplorer`, `mru`, `gruvbox`, `vim-airline`, `vim-devicons`, `nerdfont.vim`, `vim-fugitive`, `vim-commentary`, `vim-surround`, `ale`, and `vim-claude-code`.
- **Key Features:**
  - **Gruvbox** dark colorscheme, hybrid line numbers (`number relativenumber`), and system clipboard integration (`unnamedplus`).
  - Persistent undo history (`undofile`) and backups stored in `~/.vim/backup/`.
  - **Linting & Formatting (ALE):** Automatic ESLint and Prettier execution on save for JS, TS, TSX, CSS, and SCSS files, plus trailing whitespace and empty line cleanup.
  - **Main Keybindings (Leader `<Space>`):**
    - `<Leader>s` save file / `<Leader>q` save and quit.
    - `<Leader>p` (`:Files`), `<C-p>` (`:GFiles`), `<C-g>` (`:Rg`), `<Leader>b` (`:Buffers`), `<Leader>r` (`:MRU`), `<Leader>e` (`:BufExplorer`).
    - `<C-t>` toggle NERDTree, `<C-m>` reveal current file in NERDTree.
    - `<Leader>gs` Git status, `<Leader>gc` commit, `<Leader>gP` push, `<Leader>gd` diff, `<Leader>gb` blame.
    - `gd` go to definition, `gr` find references, `gy` go to type definition, `ge` error details (via ALE).
    - `<Leader>v` inserts a `console.log('[file:line]', word); /* TODO */` statement for the word under the cursor.
    - Arrow keys are disabled in normal mode to enforce `h`, `j`, `k`, `l` navigation.

### 3. Spacemacs (`spacemacs`)
Configured for daily **JavaScript, TypeScript, and React / React Native** development:
- **Active Layers:** `auto-completion`, `better-defaults`, `emacs-lisp`, `git`, `helm`, `html`, `json`, `lsp`, `markdown`, `multiple-cursors`, `spell-checking`, `syntax-checking`, `version-control`, `prettier`, `javascript`, `typescript`, `react`, `ruby`, `osx`, `treemacs`.
- **Project-local Tooling:** Automatically resolves project binaries from `node_modules/.bin` (`prettier`, `eslint`, `typescript-language-server`).
- **Behavior:**
  - Formats on save with Prettier in JS/TS buffers.
  - Maps `gd` and `gD` in Evil normal mode to `xref-find-definitions` over LSP for consistency with Neovim.
  - Honors `.editorconfig` and disables lockfiles (`.#*`) to keep repositories clean.
  - Maps macOS `Command` to `Hyper` and left `Option` to `Meta`.

### 4. Tmux (`tmux.conf`)
- **Prefix:** `Ctrl-a` (replaces `Ctrl-b`) with mouse support enabled (`mouse on`).
- **Pane & Window Management:**
  - `<Prefix> |`: Split pane horizontally in the current directory.
  - `<Prefix> -`: Split pane vertically in the current directory.
  - `<Prefix> H / J / K / L`: Resize panes in 5-cell increments.
  - `<Prefix> Ctrl-h / Ctrl-l`: Switch to previous / next window.
- **Claude CLI Integration:**
  - `<Prefix> g`: Opens a 90% floating popup window running `claude` in the active pane's current working directory.
- **Theme & Plugins (TPM):**
  - Styled with **Catppuccin Mocha High Contrast** (includes commented presets for standard *Mocha* and *Catppuccin Latte*).
  - Plugins managed via **TPM**: `tmux-sensible`, `vim-tmux-navigator`, `tmux-yank`, `tmux-open`.

### 5. Lazygit (`lazygit/config.yml`)
- Rounded borders, Nerd Fonts v3 icons, and **Catppuccin Mocha** color palette.
- Configured to open and edit files directly in **Neovim** (`nvim {{filename}}`), suspending Lazygit until the editor exits.
- Disables `autoFetch` on startup for faster responsiveness.
- **Custom Command:** Pressing `<Ctrl-u>` prompts for an upstream branch (defaults to `develop`) and runs `git pull --rebase upstream <branch>`.

### 6. IdeaVim (`ideavimrc`)
Configuration for the IdeaVim plugin across JetBrains IDEs with `<Space>` as the leader key:
- **Search & Files:** `<Leader>f` Goto File, `<Leader>p` Search Everywhere, `<Leader>r` Recent Files, `<Leader>e` Select in Project View, `<Leader>s` File Structure popup.
- **Code Navigation:** `gd` declaration, `gD` type declaration, `gi` implementation, `gr` find usages, `gt` go to test, `<Leader>a` intention actions.
- **Refactoring & Formatting:** `<Leader>rn` rename element, `<Leader>cf` reformat code, `<Leader>co` optimize imports, `<Leader>cc` toggle line comment.
- **Run & Debug:** `<Leader>rr` run, `<Leader>rd` debug, `<Leader>rb` toggle breakpoint, `<Leader>rc` resume, `<Leader>rs` step over, `<Leader>ri` step into, `<Leader>ro` step out, `<Leader>rx` stop.
- **Git / VCS:** `<Leader>gg` VCS tool window, `<Leader>gl` Git log, `<Leader>ga` annotate (*git blame*).
- **Tool Windows & Tabs:** `Shift-h` / `Shift-l` switch tabs; `<Leader>1` Project window, `<Leader>3` VCS window, `<Leader>4` Terminal window.

### 7. GnuCash (`gnucash.css`)
Custom CSS stylesheet designed to improve the layout and print/PDF output of GnuCash invoices (tested with GnuCash 4.x), styling headers, entry tables, totals, and page margins.

---

## Installation

### Prerequisites
1. **macOS** with [Homebrew](https://brew.sh/) installed.
2. **Git** available on your system.

### Step-by-Step Setup

1. **Clone the repository into `~/GitHub/dotfiles`:**
   > **Note:** `install.sh` expects the repository to live at `$HOME/GitHub/dotfiles`.

   ```bash
   mkdir -p ~/GitHub
   git clone https://github.com/gustavomcortez/dotfiles.git ~/GitHub/dotfiles
   cd ~/GitHub/dotfiles
   ```

2. **Run the bootstrap script:**

   ```bash
   bash install.sh
   ```

   **What `install.sh` does:**
   - Installs CLI tools and GUI cask packages via Homebrew (skipping any that are already installed).
   - Creates required directories (`~/.config` and `~/.vim/backup`).
   - Creates symlinks pointing to this repository for Neovim, Vim, Spacemacs, Tmux, EditorConfig, and Lazygit.
   - Automatically **backs up any pre-existing real files or directories** to `~/.dotfiles_backup/<YYYYMMDD_HHMMSS>/` before replacing them with symlinks.

3. **Optional Post-Install Steps:**
   - **IdeaVim:** If you use JetBrains IDEs, symlink `ideavimrc`:
     ```bash
     ln -sf ~/GitHub/dotfiles/ideavimrc ~/.ideavimrc
     ```
   - **TPM (Tmux Plugin Manager):** On a fresh machine, clone TPM and press `<Prefix> I` (`Ctrl-a` + `Shift-i` inside Tmux) to install plugins:
     ```bash
     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
     ```
   - **iTerm2:**
     - Go to *Preferences → Profiles → Colors* and import the **Catppuccin Mocha** theme.
     - Go to *Preferences → Profiles → Text* and set the font to **JetBrainsMono Nerd Font Mono**.
   - **GnuCash:** Paste or reference the contents of `gnucash.css` in your GnuCash invoice report stylesheet settings.

---

## Updating & Maintenance

### Pulling the Latest Dotfiles Changes
To pull recent updates from the repository and ensure all symlinks and Homebrew packages are in sync:

```bash
cd ~/GitHub/dotfiles
git pull
bash install.sh
```
`install.sh` is **idempotent** and safe to re-run at any time—already installed packages and valid symlinks are skipped without side effects.

### Updating Packages & Plugins

- **Homebrew Packages:**
  ```bash
  brew update && brew upgrade
  ```

- **Neovim (LazyVim):**
  - Open `nvim` and run `:Lazy sync` (or press `<Space>l` to open the Lazy UI, then press `S`).
  - `nvim/lazy-lock.json` locks exact plugin commits; commit changes to this file after updating plugins to keep your setup reproducible across machines.
  - To update LSP servers, linters, and formatters managed by Mason, run `:MasonUpdate` inside Neovim.

- **Vim (vim-plug):**
  - Open `vim` and run:
    - `:PlugInstall` to install newly added plugins.
    - `:PlugUpdate` to update installed plugins.
    - `:PlugClean` to remove unused plugins deleted from `vimrc`.

- **Spacemacs:**
  - Inside Spacemacs, press `SPC f e U` to update layer packages, and `SPC f e R` to reload your configuration after editing `spacemacs`.

- **Tmux (TPM):**
  - Inside a Tmux session:
    - `Ctrl-a` + `Shift-i` (`<Prefix> I`): Install new plugins listed in `tmux.conf`.
    - `Ctrl-a` + `Shift-u` (`<Prefix> U`): Update installed plugins.
    - Reload `tmux.conf` without restarting Tmux: `tmux source-file ~/.tmux.conf`.

### Adding or Modifying Configurations

1. **Editing an existing config:**
   Because the files in `~/` and `~/.config/` are symlinked to `~/GitHub/dotfiles`, editing `~/.vimrc`, `~/.tmux.conf`, `~/.spacemacs`, or `~/.config/nvim/` directly modifies the files in this repository. Simply review your changes with `git status` / `lazygit` and commit them.

2. **Adding a new tool or dotfile:**
   - Place the configuration file or directory inside `~/GitHub/dotfiles/`.
   - If it requires a Homebrew package, add it to `brew_install` or `brew_cask_install` in `install.sh`.
   - Add a `link <repo-relative-path> <destination>` entry in `install.sh`.
   - Run `bash install.sh` to create the symlink and verify everything works.

3. **Restoring Backups:**
   If you ever need to recover a file that was replaced by `install.sh`, check the timestamped directories under `~/.dotfiles_backup/`.

---

## License

Distributed under the [MIT License](LICENSE).
