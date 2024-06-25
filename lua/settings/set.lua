vim.opt.guicursor = ""

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = false

-- set Python indentation
vim.g.python_indent = {
    open_paren = "shiftwidth()",
    continu  = "shiftwidth()",
    closed_paren_align_last_line = false
}


vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "88"
vim.opt.textwidth = 88

-- How many tenths of a second to blink when matching brackets
vim.opt.mat=10

-- Set the number of lines of history VIM has to keep
vim.opt.history=500

-- do incremental searching
vim.opt.incsearch = true

-- make search case insensitive...
vim.opt.ignorecase = true

-- open file at previous location
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec("normal! g'\"", false)
        end
    end
})
