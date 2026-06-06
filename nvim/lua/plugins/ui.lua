return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local noirbuddy_lualine = require("noirbuddy.plugins.lualine")
			opts.options = opts.options or {}
			opts.options.theme = noirbuddy_lualine.theme
			opts.sections = vim.tbl_deep_extend("force", opts.sections or {}, noirbuddy_lualine.sections)
			opts.inactive_sections = vim.tbl_deep_extend(
				"force",
				opts.inactive_sections or {},
				noirbuddy_lualine.inactive_sections
			)
		end,
	},
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("noirbuddy.colors").all()

			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.primary, guifg = colors.noir_0 },
						InclineNormalNC = { guifg = colors.noir_4, guibg = colors.noir_7 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			local colors = require("noirbuddy.colors").all()
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = colors.noir_6 })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitle", { fg = colors.noir_4 })
			vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = colors.primary })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", { fg = colors.noir_6 })

			opts.cmdline = {
				format = {
					cmdline = { icon = ">" },
					search_down = { icon = "/" },
					search_up = { icon = "?" },
				},
			}
			opts.views = {
				cmdline_popup = {
					border = { style = "single", padding = { 0, 1 } },
					position = { row = "40%", col = "50%" },
					size = { width = 60 },
				},
			}
		end,
	},
	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					border = "single",
					scrollbar = false,
				},
			},
			cmdline = { enabled = false },
		},
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
			},
			on_open = function()
				vim.api.nvim_create_autocmd("VimLeavePre", {
					group = vim.api.nvim_create_augroup("zen_restore_tmux", { clear = true }),
					callback = function()
						vim.fn.system("tmux set status on")
					end,
				})
			end,
			on_close = function()
				pcall(vim.api.nvim_del_augroup_by_name, "zen_restore_tmux")
			end,
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
}
