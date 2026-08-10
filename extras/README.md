# Terminal themes

Matching terminal themes for Origin are included in this directory.

| Terminal | File | Installation |
| --- | --- | --- |
| Alacritty | `alacritty/origin.toml` | Import the file from `alacritty.toml` |
| foot | `foot/origin.ini` | Include the file from `foot.ini` |
| Ghostty | `ghostty/origin` | Copy to `~/.config/ghostty/themes/` and set `theme = origin` |
| iTerm2 | `iterm2/origin.itermcolors` | Import from Profiles → Colors → Color Presets |
| Kitty | `kitty/origin.conf` | Include the file from `kitty.conf` |
| Konsole | `konsole/origin.colorscheme` | Copy to `~/.local/share/konsole/` |
| Warp | `warp/origin.yaml` | Copy to `~/.warp/themes/` |
| WezTerm | `wezterm/origin.lua` | Load the returned color table from `wezterm.lua` |
| Windows Terminal | `windows-terminal/origin.json` | Add the object to `schemes` in `settings.json` |
| tmux | `tmux/origin.conf` | Source the file from `.tmux.conf` |

Examples:

```toml
# alacritty.toml
[general]
import = ["~/.config/alacritty/origin.toml"]
```

```conf
# kitty.conf
include ~/.config/kitty/origin.conf

# tmux.conf
source-file ~/.config/tmux/origin.conf
```

```lua
-- wezterm.lua
config.colors = dofile(wezterm.config_dir .. "/origin.lua")
```

The files are generated from [`lua/origin/palette.lua`](../lua/origin/palette.lua). After changing the palette, regenerate them with:

```sh
make extras
```
