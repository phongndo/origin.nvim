local function hex(value)
  return tonumber(value:sub(2), 16)
end

local function highlight(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function luminance(color)
  local channels = {}
  for offset = 2, 6, 2 do
    local value = tonumber(color:sub(offset, offset + 1), 16) / 255
    channels[#channels + 1] = value <= 0.04045 and value / 12.92 or ((value + 0.055) / 1.055) ^ 2.4
  end
  return 0.2126 * channels[1] + 0.7152 * channels[2] + 0.0722 * channels[3]
end

local function contrast(left, right)
  local a, b = luminance(left), luminance(right)
  local light, dark = math.max(a, b), math.min(a, b)
  return (light + 0.05) / (dark + 0.05)
end

local origin = require("origin")
local palette_module = require("origin.palette")
local base_color_count = 0
for _ in pairs(palette_module.base) do
  base_color_count = base_color_count + 1
end
assert(base_color_count == 6)
assert(origin.version == "0.1.0")
assert(not pcall(palette_module.get, { void = "black" }))
origin.setup()
vim.cmd.colorscheme("origin")

local c = origin.get_palette()
assert(vim.g.colors_name == "origin")
assert(highlight("Normal").fg == hex(c.starlight))
assert(highlight("Normal").bg == hex(c.void))
assert(highlight("Keyword").fg == hex(c.starlight))
assert(highlight("Keyword").bold)
assert(highlight("Function").fg == hex(c.starlight))
assert(not highlight("Function").bold)
assert(not highlight("Function").italic)
assert(not highlight("Function").underline)
assert(highlight("Type").fg == hex(c.blueshift))
assert(not highlight("Type").underline)
for _, group in ipairs({ "Constant", "String", "Character", "Number", "Boolean", "Float" }) do
  assert(highlight(group).fg == hex(c.starlight))
  assert(not highlight(group).bold)
  assert(not highlight(group).italic)
  assert(not highlight(group).underline)
end
assert(highlight("Comment").italic)

-- Language-specific Tree-sitter captures.
assert(highlight("@origin.choice").fg == hex(c.corona))
assert(highlight("@origin.choice").bold)
assert(highlight("@origin.choice").nocombine)
assert(not highlight("@origin.choice").underline)
assert(highlight("@origin.escape").fg == hex(c.corona))
assert(highlight("@origin.escape").bold)
assert(highlight("@origin.escape").nocombine)
assert(not highlight("@origin.escape").underline)
assert(highlight("@origin.structure").fg == hex(c.starlight))
assert(highlight("@origin.structure").bold)
assert(highlight("@origin.type.marker").fg == hex(c.blueshift))
assert(highlight("@origin.type.marker").nocombine)
assert(not highlight("@origin.type.marker").underline)
assert(highlight("@keyword.function").fg == hex(c.starlight))
assert(highlight("@keyword.function").bold)
assert(highlight("@keyword.conditional").fg == hex(c.corona))
assert(highlight("@keyword.repeat").fg == hex(c.corona))
assert(highlight("@keyword.type").fg == hex(c.blueshift))
assert(highlight("Structure").fg == hex(c.blueshift))
assert(highlight("@function").fg == hex(c.starlight))
assert(highlight("@function").bold)
assert(highlight("@function").nocombine)
assert(not highlight("@function").underline)
assert(highlight("@function.call").fg == hex(c.starlight))
assert(not highlight("@function.call").bold)
assert(not highlight("@function.call").italic)
assert(not highlight("@function.call").underline)
assert(highlight("@lsp.typemod.variable.declaration").bold)
assert(not highlight("@lsp.typemod.variable.declaration").underline)
assert(highlight("@type.definition").fg == hex(c.starlight))
assert(highlight("@type.definition").bold)
assert(not highlight("@type.definition").underline)
assert(highlight("@type").fg == hex(c.blueshift))
assert(highlight("@type").nocombine)
assert(not highlight("@type").underline)
assert(highlight("@attribute").fg == hex(c.ash))
assert(not highlight("@attribute").bold)
assert(not highlight("@attribute").underline)
assert(highlight("@function.macro").fg == hex(c.ash))
assert(highlight("@keyword.import").fg == hex(c.ash))
assert(highlight("@keyword.return").fg == hex(c.corona))
assert(highlight("@keyword.return").bold)
assert(highlight("@keyword.return").nocombine)
assert(not highlight("@keyword.return").underline)
assert(highlight("@keyword.coroutine").fg == hex(c.corona))
assert(highlight("@keyword.exception").fg == hex(c.corona))
assert(highlight("@lsp.type.typeParameter").fg == hex(c.blueshift))
assert(highlight("@lsp.typemod.function.definition").fg == hex(c.starlight))
assert(highlight("@lsp.typemod.function.definition").nocombine)
assert(not highlight("@lsp.typemod.function.definition").underline)

-- Diagnostics and plugin integrations.
assert(highlight("DiagnosticError").fg == hex(c.redshift))
assert(highlight("DiagnosticWarn").fg == hex(c.corona))
assert(highlight("DiagnosticInfo").fg == hex(c.blueshift))
assert(highlight("DiagnosticOk").fg == hex(c.blueshift))
for severity, color in pairs({
  Error = c.redshift,
  Warn = c.corona,
  Info = c.blueshift,
  Hint = c.ash,
  Ok = c.blueshift,
}) do
  local group = highlight("DiagnosticUnderline" .. severity)
  assert(group.fg == nil)
  assert(group.sp == hex(color))
  assert(not group.underline)
  assert(not group.nocombine)
  assert(group.undercurl)
end
assert(highlight("GitSignsAdd").fg == hex(c.blueshift))
assert(highlight("TelescopeMatching").fg == hex(c.corona))
assert(highlight("BlinkCmpKindFunction").fg == hex(c.muted))
assert(highlight("MiniIconsRed").fg == hex(c.muted))
assert(highlight("RainbowDelimiterRed").fg == hex(c.starlight))

local lualine = require("lualine.themes.origin")
assert(lualine.normal.a.bg == c.starlight)
assert(lualine.insert.a.bg == c.starlight)
assert(lualine.replace.a.bg == c.redshift)
assert(vim.g.terminal_color_0 == c.void)
assert(vim.g.terminal_color_1 == c.redshift)
assert(vim.g.terminal_color_2 == c.blueshift)
assert(vim.g.terminal_color_3 == c.corona)
assert(vim.g.terminal_color_5 == c.ash)
assert(vim.g.terminal_color_6 == c.blueshift)
assert(vim.g.terminal_color_15 == c.starlight)

local pi_theme = vim.json.decode(table.concat(vim.fn.readfile("extras/pi/origin.json"), "\n"))
assert(pi_theme.name == "origin")
assert(pi_theme.vars.void == c.void)
assert(pi_theme.vars.starlight == c.starlight)
assert(pi_theme.vars.corona == c.corona)
assert(pi_theme.vars.redshift == c.redshift)
assert(pi_theme.vars.blueshift == c.blueshift)
assert(pi_theme.vars.terminal == "")
for _, name in ipairs({
  "accent",
  "border",
  "borderAccent",
  "borderMuted",
  "success",
  "error",
  "warning",
  "muted",
  "dim",
  "text",
  "thinkingText",
  "selectedBg",
  "scrollbarThumb",
  "userMessageBg",
  "userMessageText",
  "customMessageBg",
  "customMessageText",
  "customMessageLabel",
  "toolPendingBg",
  "toolSuccessBg",
  "toolErrorBg",
  "toolTitle",
  "toolOutput",
  "mdHeading",
  "mdLink",
  "mdLinkUrl",
  "mdCode",
  "mdCodeBlock",
  "mdCodeBlockBorder",
  "mdQuote",
  "mdQuoteBorder",
  "mdHr",
  "mdListBullet",
  "toolDiffAdded",
  "toolDiffRemoved",
  "toolDiffContext",
  "syntaxComment",
  "syntaxKeyword",
  "syntaxFunction",
  "syntaxVariable",
  "syntaxString",
  "syntaxNumber",
  "syntaxType",
  "syntaxOperator",
  "syntaxPunctuation",
  "thinkingOff",
  "thinkingMinimal",
  "thinkingLow",
  "thinkingMedium",
  "thinkingHigh",
  "thinkingXhigh",
  "thinkingMax",
  "bashMode",
}) do
  assert(pi_theme.colors[name] ~= nil, "Pi theme is missing " .. name)
end

for _, name in ipairs({ "starlight", "ash", "corona", "redshift", "blueshift" }) do
  assert(contrast(c.void, c[name]) >= 7.0, name .. " does not meet WCAG AAA")
end
for _, name in ipairs({ "corona", "redshift", "blueshift" }) do
  assert(c[name .. "_dim"] ~= c[name])
  assert(c[name .. "_bright"] ~= c[name])
end
assert(contrast(c.void, c.subtle) >= 4.5, "subtle text does not meet WCAG AA")
assert(contrast(c.void, c.border) >= 4.5, "borders do not meet WCAG AA")

origin.setup({
  transparent = true,
  dim_inactive = true,
  palette = { corona = "#FFFFFF" },
  styles = { comments = { italic = false } },
  overrides = function(colors)
    return { SpecialKey = { fg = colors.redshift, bold = true } }
  end,
})
vim.cmd.colorscheme("origin")
assert(highlight("Normal").bg == nil)
assert(highlight("NormalNC").fg == hex(c.ash))
for _, group in ipairs({
  "NormalFloat",
  "FloatBorder",
  "Pmenu",
  "TelescopeNormal",
  "TelescopePromptNormal",
  "FzfLuaNormal",
  "SnacksNormal",
  "SnacksPicker",
  "SnacksPickerInputBorder",
  "BlinkCmpMenu",
  "BlinkCmpDoc",
}) do
  assert(highlight(group).bg == nil, group .. " should inherit the terminal background")
end
assert(highlight("TelescopeSelection").bg == hex(c.selection))
assert(highlight("DiagnosticWarn").fg == 0xFFFFFF)
assert(not highlight("Comment").italic)
assert(highlight("SpecialKey").fg == hex(c.redshift))
assert(highlight("SpecialKey").bold)

local colorscheme_events = 0
vim.api.nvim_create_autocmd("ColorScheme", {
  once = true,
  callback = function()
    colorscheme_events = colorscheme_events + 1
  end,
})
origin.reload()
assert(colorscheme_events == 1)

print("origin.nvim smoke tests passed")
