return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      start_insert = false,
      auto_insert = false,
      win = {
        position = "right",
        width = 0.4,
      },
    },
    dashboard = { enabled = false },
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right",
            },
          },
        },
        command_history = {
          layout = {
            preset = "select",
          },
        },
      },
    },
  },
}
