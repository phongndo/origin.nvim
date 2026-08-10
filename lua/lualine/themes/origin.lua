local c = require("origin").get_palette()

local function mode(accent)
  return {
    a = { fg = c.void, bg = accent, gui = "bold" },
    b = { fg = c.fg, bg = c.surface2 },
    c = { fg = c.muted, bg = c.surface0 },
  }
end

return {
  normal = mode(c.starlight),
  insert = mode(c.starlight),
  visual = mode(c.ash),
  replace = mode(c.redshift),
  command = mode(c.starlight),
  terminal = mode(c.ash),
  inactive = {
    a = { fg = c.subtle, bg = c.surface0 },
    b = { fg = c.subtle, bg = c.surface0 },
    c = { fg = c.subtle, bg = c.surface0 },
  },
}
