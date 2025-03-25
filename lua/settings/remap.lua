vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Buffer
vim.keymap.set('n', '<C-j>', ':bnext<CR>', {
    noremap = true,
    silent = true,
    desc = 'Go to next buffer'
})
vim.keymap.set('n', '<C-k>', ':bprevious<CR>', {
    noremap = true,
    silent = true,
    desc = 'Go to previous buffer'
})
