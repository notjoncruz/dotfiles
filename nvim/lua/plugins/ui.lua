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
}
