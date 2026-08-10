local M = {}

-- Configurable base colors. UI shades and surfaces are generated below.
M.base = {
  void = "#050507",
  starlight = "#DCD9D2",
  ash = "#9A96A0",
  corona = "#E8A15F",
  redshift = "#E77E70",
  blueshift = "#82A8E0",
}

local function channel(hex, offset)
  return tonumber(hex:sub(offset, offset + 1), 16)
end

-- Blend foreground over background in sRGB space.
local function blend(foreground, background, alpha)
  local channels = {}
  for offset = 2, 6, 2 do
    local fg = channel(foreground, offset)
    local bg = channel(background, offset)
    channels[#channels + 1] = math.floor(bg + (fg - bg) * alpha + 0.5)
  end

  return string.format("#%02X%02X%02X", channels[1], channels[2], channels[3])
end

function M.get(overrides)
  local c = vim.tbl_extend("force", M.base, overrides or {})
  for name in pairs(M.base) do
    if type(c[name]) ~= "string" or not c[name]:match("^#%x%x%x%x%x%x$") then
      error(string.format("origin: palette.%s must be a six-digit hex color", name))
    end
  end

  c.bg = c.void
  c.fg = c.starlight
  c.muted = c.ash
  c.halo = c.starlight

  -- Generate dim and bright accent variants.
  for _, name in ipairs({ "corona", "redshift", "blueshift" }) do
    c[name .. "_dim"] = blend(c[name], c.void, 0.14)
    c[name .. "_bright"] = blend(c.starlight, c[name], 0.14)
  end

  -- Neutral depth without expanding the base palette.
  c.surface0 = blend(c.starlight, c.void, 0.035)
  c.surface1 = blend(c.starlight, c.void, 0.065)
  c.surface2 = blend(c.starlight, c.void, 0.10)
  c.border = blend(c.ash, c.void, 0.78)
  c.subtle = blend(c.ash, c.void, 0.80)

  -- Tinted surfaces use dim shades from the three disk colors.
  c.selection = blend(c.blueshift, c.void, 0.20)
  c.warm_surface = blend(c.corona, c.void, 0.18)
  c.info_surface = c.blueshift_dim
  c.success_surface = c.blueshift_dim
  c.diff_add = c.blueshift_dim
  c.diff_change = c.corona_dim
  c.diff_delete = c.redshift_dim

  return c
end

return M
