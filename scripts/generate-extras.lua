local source = debug.getinfo(1, "S").source:sub(2)
local root = vim.fs.dirname(vim.fs.dirname(vim.fs.normalize(source)))
vim.opt.runtimepath:prepend(root)

local c = require("origin.palette").get()
local ansi = {
  c.void,
  c.redshift,
  c.blueshift,
  c.corona,
  c.blueshift,
  c.ash,
  c.blueshift,
  c.starlight,
  c.ash,
  c.redshift_bright,
  c.blueshift_bright,
  c.corona_bright,
  c.blueshift_bright,
  c.starlight,
  c.blueshift_bright,
  c.starlight,
}

local function write(relative, content)
  local path = root .. "/" .. relative
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  local file = assert(io.open(path, "w"))
  file:write(content)
  file:close()
end

local function bare(hex)
  return hex:sub(2)
end

local kitty = {
  "# Origin — generated from lua/origin/palette.lua",
  "background " .. c.bg,
  "foreground " .. c.fg,
  "cursor " .. c.starlight,
  "cursor_text_color " .. c.void,
  "selection_background " .. c.selection,
  "selection_foreground " .. c.starlight,
  "url_color " .. c.starlight,
}
for index, color in ipairs(ansi) do
  kitty[#kitty + 1] = string.format("color%d %s", index - 1, color)
end
write("extras/kitty/origin.conf", table.concat(kitty, "\n") .. "\n")

local ghostty = {
  "# Origin — generated from lua/origin/palette.lua",
  "background = " .. c.bg,
  "foreground = " .. c.fg,
  "cursor-color = " .. c.starlight,
  "cursor-text = " .. c.void,
  "selection-background = " .. c.selection,
  "selection-foreground = " .. c.starlight,
}
for index, color in ipairs(ansi) do
  ghostty[#ghostty + 1] = string.format("palette = %d=%s", index - 1, color)
end
write("extras/ghostty/origin", table.concat(ghostty, "\n") .. "\n")

local alacritty = string.format(
  [[# Origin — generated from lua/origin/palette.lua
[colors.primary]
background = "%s"
foreground = "%s"

[colors.cursor]
text = "%s"
cursor = "%s"

[colors.selection]
text = "%s"
background = "%s"

[colors.normal]
black = "%s"
red = "%s"
green = "%s"
yellow = "%s"
blue = "%s"
magenta = "%s"
cyan = "%s"
white = "%s"

[colors.bright]
black = "%s"
red = "%s"
green = "%s"
yellow = "%s"
blue = "%s"
magenta = "%s"
cyan = "%s"
white = "%s"
]],
  c.bg,
  c.fg,
  c.void,
  c.starlight,
  c.starlight,
  c.selection,
  unpack(ansi)
)
write("extras/alacritty/origin.toml", alacritty)

local wezterm = string.format(
  [[-- Origin — generated from lua/origin/palette.lua
return {
  foreground = "%s",
  background = "%s",
  cursor_bg = "%s",
  cursor_fg = "%s",
  cursor_border = "%s",
  selection_fg = "%s",
  selection_bg = "%s",
  ansi = { "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s" },
  brights = { "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s" },
}
]],
  c.fg,
  c.bg,
  c.starlight,
  c.void,
  c.starlight,
  c.starlight,
  c.selection,
  unpack(ansi)
)
write("extras/wezterm/origin.lua", wezterm)

local windows = {
  name = "Origin",
  background = c.bg,
  foreground = c.fg,
  cursorColor = c.starlight,
  selectionBackground = c.selection,
  black = ansi[1],
  red = ansi[2],
  green = ansi[3],
  yellow = ansi[4],
  blue = ansi[5],
  purple = ansi[6],
  cyan = ansi[7],
  white = ansi[8],
  brightBlack = ansi[9],
  brightRed = ansi[10],
  brightGreen = ansi[11],
  brightYellow = ansi[12],
  brightBlue = ansi[13],
  brightPurple = ansi[14],
  brightCyan = ansi[15],
  brightWhite = ansi[16],
}
local windows_json = { "{" }
local windows_keys = {
  "name",
  "background",
  "foreground",
  "cursorColor",
  "selectionBackground",
  "black",
  "red",
  "green",
  "yellow",
  "blue",
  "purple",
  "cyan",
  "white",
  "brightBlack",
  "brightRed",
  "brightGreen",
  "brightYellow",
  "brightBlue",
  "brightPurple",
  "brightCyan",
  "brightWhite",
}
for index, key in ipairs(windows_keys) do
  local comma = index == #windows_keys and "" or ","
  windows_json[#windows_json + 1] = string.format("  %q: %q%s", key, windows[key], comma)
end
windows_json[#windows_json + 1] = "}"
write("extras/windows-terminal/origin.json", table.concat(windows_json, "\n") .. "\n")

local foot = {
  "# Origin — generated from lua/origin/palette.lua",
  "[colors]",
  "background=" .. bare(c.bg),
  "foreground=" .. bare(c.fg),
  "selection-foreground=" .. bare(c.starlight),
  "selection-background=" .. bare(c.selection),
}
for index = 1, 8 do
  foot[#foot + 1] = string.format("regular%d=%s", index - 1, bare(ansi[index]))
end
for index = 9, 16 do
  foot[#foot + 1] = string.format("bright%d=%s", index - 9, bare(ansi[index]))
end
write("extras/foot/origin.ini", table.concat(foot, "\n") .. "\n")

local warp = string.format(
  [[# Origin — generated from lua/origin/palette.lua
accent: "%s"
background: "%s"
details: darker
foreground: "%s"
terminal_colors:
  normal:
    black: "%s"
    red: "%s"
    green: "%s"
    yellow: "%s"
    blue: "%s"
    magenta: "%s"
    cyan: "%s"
    white: "%s"
  bright:
    black: "%s"
    red: "%s"
    green: "%s"
    yellow: "%s"
    blue: "%s"
    magenta: "%s"
    cyan: "%s"
    white: "%s"
]],
  c.starlight,
  c.bg,
  c.fg,
  unpack(ansi)
)
write("extras/warp/origin.yaml", warp)

local tmux = string.format(
  [[# Origin — generated from lua/origin/palette.lua
set -g status-style "fg=%s,bg=%s"
set -g message-style "fg=%s,bg=%s,bold"
set -g message-command-style "fg=%s,bg=%s"
set -g pane-border-style "fg=%s"
set -g pane-active-border-style "fg=%s"
set -g mode-style "fg=%s,bg=%s,bold"
set -g window-status-style "fg=%s,bg=%s"
set -g window-status-current-style "fg=%s,bg=%s,bold"
]],
  c.muted,
  c.surface0,
  c.void,
  c.starlight,
  c.fg,
  c.surface2,
  c.border,
  c.starlight,
  c.void,
  c.starlight,
  c.muted,
  c.surface0,
  c.starlight,
  c.surface1
)
write("extras/tmux/origin.conf", tmux)

local function rgb(hex)
  return table.concat({
    tonumber(hex:sub(2, 3), 16),
    tonumber(hex:sub(4, 5), 16),
    tonumber(hex:sub(6, 7), 16),
  }, ",")
end

local konsole = {
  "# Origin — generated from lua/origin/palette.lua",
  "[General]",
  "Description=Origin",
  "Opacity=1",
  "",
  "[Background]",
  "Color=" .. rgb(c.bg),
  "",
  "[Foreground]",
  "Color=" .. rgb(c.fg),
}
for index = 1, 8 do
  konsole[#konsole + 1] = ""
  konsole[#konsole + 1] = string.format("[Color%d]", index - 1)
  konsole[#konsole + 1] = "Color=" .. rgb(ansi[index])
  konsole[#konsole + 1] = ""
  konsole[#konsole + 1] = string.format("[Color%dIntense]", index - 1)
  konsole[#konsole + 1] = "Color=" .. rgb(ansi[index + 8])
end
write("extras/konsole/origin.colorscheme", table.concat(konsole, "\n") .. "\n")

local function plist_color(name, hex)
  local function component(offset)
    return tonumber(hex:sub(offset, offset + 1), 16) / 255
  end
  return string.format(
    [[  <key>%s</key>
  <dict>
    <key>Alpha Component</key><real>1</real>
    <key>Blue Component</key><real>%.15f</real>
    <key>Color Space</key><string>sRGB</string>
    <key>Green Component</key><real>%.15f</real>
    <key>Red Component</key><real>%.15f</real>
  </dict>
]],
    name,
    component(6),
    component(4),
    component(2)
  )
end

local iterm = {
  [[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
]],
}
for index, color in ipairs(ansi) do
  iterm[#iterm + 1] = plist_color("Ansi " .. (index - 1) .. " Color", color)
end
iterm[#iterm + 1] = plist_color("Background Color", c.bg)
iterm[#iterm + 1] = plist_color("Bold Color", c.starlight)
iterm[#iterm + 1] = plist_color("Cursor Color", c.starlight)
iterm[#iterm + 1] = plist_color("Cursor Text Color", c.void)
iterm[#iterm + 1] = plist_color("Foreground Color", c.fg)
iterm[#iterm + 1] = plist_color("Selected Text Color", c.starlight)
iterm[#iterm + 1] = plist_color("Selection Color", c.selection)
iterm[#iterm + 1] = "</dict>\n</plist>\n"
write("extras/iterm2/origin.itermcolors", table.concat(iterm))

local pi = string.format(
  [[{
  "$schema": "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json",
  "name": "origin",
  "vars": {
    "void": "%s",
    "starlight": "%s",
    "ash": "%s",
    "corona": "%s",
    "redshift": "%s",
    "blueshift": "%s",
    "border": "%s",
    "subtle": "%s",
    "surface0": "%s",
    "surface1": "%s",
    "surface2": "%s",
    "selection": "%s",
    "warmSurface": "%s",
    "coronaBright": "%s",
    "terminal": ""
  },
  "colors": {
    "accent": "corona",
    "border": "ash",
    "borderAccent": "corona",
    "borderMuted": "border",
    "success": "blueshift",
    "error": "redshift",
    "warning": "corona",
    "muted": "ash",
    "dim": "subtle",
    "text": "starlight",
    "thinkingText": "ash",

    "selectedBg": "selection",
    "scrollbarThumb": "surface2",
    "userMessageBg": "terminal",
    "userMessageText": "starlight",
    "customMessageBg": "terminal",
    "customMessageText": "starlight",
    "customMessageLabel": "corona",
    "toolPendingBg": "terminal",
    "toolSuccessBg": "terminal",
    "toolErrorBg": "terminal",
    "toolTitle": "corona",
    "toolOutput": "starlight",

    "mdHeading": "starlight",
    "mdLink": "blueshift",
    "mdLinkUrl": "ash",
    "mdCode": "blueshift",
    "mdCodeBlock": "starlight",
    "mdCodeBlockBorder": "border",
    "mdQuote": "ash",
    "mdQuoteBorder": "border",
    "mdHr": "border",
    "mdListBullet": "corona",

    "toolDiffAdded": "blueshift",
    "toolDiffRemoved": "redshift",
    "toolDiffContext": "ash",

    "syntaxComment": "ash",
    "syntaxKeyword": "corona",
    "syntaxFunction": "starlight",
    "syntaxVariable": "starlight",
    "syntaxString": "starlight",
    "syntaxNumber": "starlight",
    "syntaxType": "blueshift",
    "syntaxOperator": "starlight",
    "syntaxPunctuation": "ash",

    "thinkingOff": "surface2",
    "thinkingMinimal": "border",
    "thinkingLow": "ash",
    "thinkingMedium": "blueshift",
    "thinkingHigh": "corona",
    "thinkingXhigh": "coronaBright",
    "thinkingMax": "starlight",

    "bashMode": "corona"
  },
  "export": {
    "pageBg": "void",
    "cardBg": "surface1",
    "infoBg": "warmSurface"
  }
}
]],
  c.void,
  c.starlight,
  c.ash,
  c.corona,
  c.redshift,
  c.blueshift,
  c.border,
  c.subtle,
  c.surface0,
  c.surface1,
  c.surface2,
  c.selection,
  c.warm_surface,
  c.corona_bright
)
write("extras/pi/origin.json", pi)

print("Generated themes in extras/")
