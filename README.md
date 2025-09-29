# dotfiles

## Bash

```bash
ln -s -f ~/dotfiles/.bashrc ~/.bashrc
```

## Neovim

```bash
ln -s -f ~/dotfiles/nvim/ ~/.config/nvim
```

### Dependencies

- fzf
- tree-sitter-cli
- FiraCode Nerd Font

### Optional Dependencies

#### QOL

| Package      | Arch         | Brew    | Purpose                                                                  |
| ------------ | ------------ | ------- | ------------------------------------------------------------------------ |
| ripgrep      | ripgrep      | ripgrep | fzf optimization                                                         |
| fd           | fd           | fd      | fzf optimization                                                         |
| wl-clipboard | wl-clipboard | N/A     | for c&p in wayland using `"+y` to yank into the `+` (clipboard) register |

#### Language Servers

| Language Server | Arch                                                                                                                                                                         | Brew                         |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| lua-ls          | lua-language-server                                                                                                                                                          | lua-language-server          |
| gopls           | gopls                                                                                                                                                                        | gopls                        |
| ts-ls           | typescript-language-server                                                                                                                                                   | typescript-language-server   |
| pylsp           | python-lsp-server ([Optional deps](https://github.com/palantir/python-language-server/tree/0fa74bae6fbb331498dbc39b6257d74357edea2f?tab=readme-ov-file#installation) needed) | python-language-server       |
| json            | vscode-json-languageserver                                                                                                                                                   | vscode-langservers-extracted |
| css             | vscode-css-languageserver                                                                                                                                                    | vscode-langservers-extracted |
| html            | vscode-html-languageserver                                                                                                                                                   | vscode-langservers-extracted |
| eslint          | eslint-language-server                                                                                                                                                       | vscode-langservers-extracted |
| terraform-ls    | terraform-ls [AUR](https://aur.archlinux.org/packages/terraform-ls)                                                                                                          | terraform-ls                 |
| yaml-ls         | yaml-language-server                                                                                                                                                         | yaml-language-server         |
| svelte          | svelte-language-server-git                                                                                                                                                   | svelte-language-server       |
| jdtls           | jdtls                                                                                                                                                                        | jdtls                        |
| clang           | clang                                                                                                                                                                        | clang                        |

#### Formatters

| Formatter | Arch     | Brew     |
| --------- | -------- | -------- |
| prettier  | prettier | prettier |
| stylua    | stylua   | stylua   |

#### Debuggers

| DAP   | Arch  | Brew  |
| ----- | ----- | ----- |
| delve | delve | delve |

#### Godot Integration

Godot `Editor->Text Editor->External`

- Use External Editor -> `On`
- Exec Path -> `kitty`
- Exec Flags -> `-e nvim --server /tmp/godot.pipe --remote {file}`

## kitty

```bash
ln -s -f ~/dotfiles/kitty ~/.config/kitty
```

## Wezterm

```bash
ln -s -f ~/dotfiles/.wezterm.lua ~/.wezterm.lua
```
