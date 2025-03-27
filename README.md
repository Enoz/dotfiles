# dotfiles

## nvim

#### Dependencies

- fzf

#### Optional Dependencies

- rg (fzf)
- fd (fzf)
- wl-clipboard (for c&p in wayland using `"+y` to yank into the `+` (clipboard) register)

#### Configured LSP's

| Language Server | Arch                       | Brew                         |
| --------------- | -------------------------- | ---------------------------- |
| lua-ls          | lua-language-server        | lua-language-server          |
| gopls           | gopls                      | gopls                        |
| ts-ls           | typescript-language-server | typescript-language-server   |
| pylsp           | python-language-server     | python-language-server       |
| json            | vscode-json-languageserver | vscode-langservers-extracted |
| css             | vscode-css-languageserver  | vscode-langservers-extracted |
| html            | vscode-html-languageserver | vscode-langservers-extracted |

| Formatter | Arch     | Brew     |
| --------- | -------- | -------- |
| prettier  | prettier | prettier |
| stylua    | stylua   | stylua   |

```bash
ln -s -f ~/dotfiles/nvim/ ~/.config/nvim
```

## kitty

```bash
ln -s -f ~/dotfiles/kitty ~/.config/kitty
```
