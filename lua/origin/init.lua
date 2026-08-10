local M = {}

M.version = "0.1.0"

M.config = {
  transparent = false,
  dim_inactive = false,
  terminal_colors = true,
  integrations = true,
  palette = {},
  overrides = {},
  styles = {
    comments = { italic = true },
    functions = {},
    keywords = { bold = true },
    strings = {},
    types = {},
    variables = {},
  },
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.get_palette()
  return require("origin.palette").get(M.config.palette)
end

function M.load()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "origin"

  local colors = M.get_palette()
  require("origin.groups").apply(colors, M.config)

  if M.config.integrations then
    require("origin.integrations").apply(colors, M.config)
  end

  local overrides = M.config.overrides
  if type(overrides) == "function" then
    overrides = overrides(colors)
  end
  for group, spec in pairs(overrides or {}) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end

-- Useful while tuning the palette: :OriginReload re-reads edited modules.
function M.reload()
  package.loaded["origin.palette"] = nil
  package.loaded["origin.groups"] = nil
  package.loaded["origin.integrations"] = nil
  package.loaded["lualine.themes.origin"] = nil
  vim.cmd.colorscheme("origin")
end

if vim.fn.exists(":OriginReload") == 0 then
  vim.api.nvim_create_user_command("OriginReload", M.reload, {
    desc = "Reload the Origin colorscheme from disk",
  })
end

return M
