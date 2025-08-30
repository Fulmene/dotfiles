vim.opt.number = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.pumheight = 10

-- Tab
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true

-- UTF-8
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Scrolling
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.lazyredraw = true

-- Regular Expression
vim.opt.magic = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Fold
vim.opt.foldminlines = 10

vim.cmd "autocmd BufEnter * set fo-=c fo-=r fo-=o"

vim.opt.clipboard = "unnamedplus"
vim.opt.exrc = true
vim.opt.secure = true

vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.cmdheight = 1

-- vim.cmd "autocmd CmdlineEnter * set cmdheight=1"
-- vim.cmd "autocmd CmdlineLeave * set cmdheight=0"

vim.cmd "autocmd FileType text,markdown setlocal wrap"

-- Show errors and warnings in a floating window
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
    end,
})
-- vim.diagnostic.config({
--      virtual_text = true,
--      update_in_insert = true,
-- })
