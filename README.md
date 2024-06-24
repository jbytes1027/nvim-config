# My Neovim Config
## Notable Customizations

- Overrides `statusline`
    - Shows changed git lines
    - Shows lsp diagnostic counts
- Uses marks to manage files
    - Swapped global marks to be lowercase, and local marks to be uppercase
    - Auto read and write shada on `FocusLost` and `FocusGained`
- Custom highlights that use only the basic 16 terminal colors
- `hlsearch` is active while using relevant keymaps
- [lf](https://github.com/gokcehan/lf) is the default file manager
- Misc keybindings
    - `Alt` + `h/j/k/l` for moving window focus
    - `Alt` + `Shift` + `h/j/k/l` for moving windows
    - `Ctrl` + `h/j/k/l` for resizing windows
    - `<leader>` + `f` for finding things
    - `<leader>` + `l` for lsp related actions
    - `<leader>` + `g` for git related actions
    - `<leader>` + `u` for toggling visual features
    - `<leader>` + `e` for opening the file manager
    - `<leader>` + `o` for showing the file outline

## Screenshots
![Screenshot from 2024-02-10 12-40-01](https://github.com/jbytes1027/nvim-config/assets/50090107/b9df0451-8335-4992-ac43-df537962110a)


## Plugins

See `lazy-lock.json`
