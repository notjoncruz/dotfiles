return {
  {
    "jesseleite/noirbuddy.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    lazy = false,
    priority = 1000,
    opts = {
      preset = "minimal",
    },
    config = function(_, opts)
      require("noirbuddy").setup(opts)

      local function set_transparent()
        local transparent = { bg = "NONE" }
        for _, group in ipairs({
          "Normal",
          "NormalNC",
          "NormalFloat",
          "SignColumn",
          "LineNr",
          "CursorLineNr",
          "EndOfBuffer",
          "WinSeparator",
          "FloatBorder",
          "Folded",
          "TelescopeNormal",
          "TelescopePromptNormal",
          "SnacksExplorerNormal",
          "SnacksExplorerWinBar",
        }) do
          vim.api.nvim_set_hl(0, group, transparent)
        end
      end

      set_transparent()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = set_transparent })
    end,
  },
}
