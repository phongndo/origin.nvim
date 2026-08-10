local M = {}

function M.check()
  local health = vim.health or require("health")
  local start = health.start or health.report_start
  local ok = health.ok or health.report_ok
  local warn = health.warn or health.report_warn
  local error = health.error or health.report_error
  local info = health.info or health.report_info

  start("origin.nvim")

  if vim.fn.has("nvim-0.9") == 1 then
    ok("Neovim 0.9 or newer")
  else
    error("Origin requires Neovim 0.9 or newer")
  end

  if vim.o.termguicolors then
    ok("termguicolors is enabled")
  else
    warn("termguicolors is disabled", {
      "Add `vim.opt.termguicolors = true` before loading Origin.",
    })
  end

  if vim.g.colors_name == "origin" then
    ok("Origin is the active colorscheme")
  else
    info("Origin is installed but is not the active colorscheme")
  end

  local palette_ok, palette = pcall(require("origin").get_palette)
  if palette_ok then
    ok("Palette colors are valid six-digit hex values")
  else
    error(tostring(palette))
  end

  if pcall(require, "lualine") then
    ok("lualine is available; the Origin lualine theme can be used")
  else
    info("lualine is not installed (optional)")
  end
end

return M
