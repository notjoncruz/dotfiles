-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local discipline = require("notjoncruz.discipline")
discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
-- keymap.set("n", "<C-h>", "<C-w>h")
-- keymap.set("n", "<C-k>", "<C-w>k")
-- keymap.set("n", "<C-j>", "<C-w>j")
-- keymap.set("n", "<C-l>", "<C-w>l")

-- Resize window
keymap.set("n", "<left>", "<C-w><")
keymap.set("n", "<right>", "<C-w>>")
keymap.set("n", "<up>", "<C-w>+")
keymap.set("n", "<down>", "<C-w>-")

keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
keymap.set("t", "<C-/>", "<C-\\><C-n>:close<Return>", opts)

-- Diagnostics
-- keymap.set("n", "<C-j>", function()
--   vim.diagnostic.goto_next()
-- end, opts)
