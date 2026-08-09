# .vim

My personal Vim configuration. LSP support, fuzzy finding, git integration, and sensible defaults out of the box.

## Install

Backup your existing config first:

```
mv ~/.vim ~/.vim.bak
mv ~/.vimrc ~/.vimrc.bak
```

Then pull this config:

```
curl -fLo ~/.vim/vimrc --create-dirs https://raw.githubusercontent.com/dawkrish/.vim/master/vimrc
```

Open Vim. Plugins install automatically on first launch.

## Plugins

- fzf - fuzzy file/buffer finder
- vim-lsp + asyncomplete - language server support
- vim-commentary - toggle comments
- vim-surround - change surrounding quotes/brackets
- vim-fugitive - git commands inside vim
- vim-gitgutter - git diff markers in sign column
- auto-pairs - auto-close brackets and quotes
- airline - status bar

## Keybindings

Leader is `Space`.

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `ga` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>s` | Format file |
| `<leader>f` | Fuzzy find files |
| `<leader>b` | Fuzzy find buffers |
| `<leader>pv` | Open file explorer |
| `<leader>a` | Select all |
| `gcc` | Toggle comment |
