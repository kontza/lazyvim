-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Hide numbers for oil
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fzf",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "oil",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = true
  end,
})
