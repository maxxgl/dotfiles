-- return {
--   {
--     'maxmx03/solarized.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.o.background = 'dark'  -- or 'light'
--       vim.cmd.colorscheme 'solarized'
--     end,
--   },
-- }
-- return {
--   "Tsuzat/NeoSolarized.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     vim.cmd([[ colorscheme NeoSolarized ]])
--   end,
-- }
-- return {
--   "Mofiqul/dracula.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd([[ colorscheme dracula ]])
--   end,
-- } -- lazy
-- return {
--   "tiagovla/tokyodark.nvim",
--   opts = {
--     -- custom options here
--   },
--   config = function(_, opts)
--     require("tokyodark").setup(opts) -- calling setup is optional
--     vim.cmd([[colorscheme tokyodark]])
--   end,
-- }
return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("solarized-osaka").setup({
      transparent = false,
    }) -- calling setup is optional
    vim.cmd([[ colorscheme solarized-osaka ]])
  end,
}
-- return {
--   "EdenEast/nightfox.nvim",
--   lazy = false,
--   priority = 1000, -- Ensure it loads first
--   config = function()
--     vim.cmd([[ colorscheme nightfox ]])
--   end,
-- }
