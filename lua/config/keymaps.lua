-- Keymaps are autOmatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map("n", "<leader>fy", "<cmd>let @+ = expand('%:p')<cr>", {
  desc = "Yank current buffer's absolute path",
})
map({ "n", "v" }, "ga.", function()
  require("config/textcase-picker")()
end, { desc = "Text case conversions" })
map({ "n", "v" }, "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
map({ "n", "v" }, "'", '"0')
map({ "n", "v" }, "<leader><space>", LazyVim.pick("files", { root = false }), { desc = "Find Files (cwd)" })
map({ "n", "v" }, "<leader>/", LazyVim.pick("live_grep", { root = false }), { desc = "Grep (cwd)" })

-- Dash to lubricate :)
map({ "n" }, "-", "<cmd>Oil<CR>")

-- Shortcut to Journal week
map({ "n" }, "<leader>z", "<cmd>Journal week<CR>")

-- Show buffers
map({ "n", "v" }, "<tab>", function()
  require("fzf-lua").buffers({ winopts = { preview = { hidden = "hidden" } } })
end, { desc = "Show open buffers" })
