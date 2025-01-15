--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true  -- if you include mixed case in your search, assumes you want case-sensitive

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
--   vim.opt.clipboard = 'unnamedplus'
-- end)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
-- local opts = { silent = true }
local opts = {}

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)


-- Better paste
keymap("v", "p", '"_dP', opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>", opts)
-- keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>ft", "<cmd>call VSCodeNotify('workbench.view.search')<CR>", opts)

-- command pallette
keymap("n", "<leader>fp", "<cmd>call VSCodeNotify('workbench.action.showCommands')<CR>", opts)


-- Comment
keymap("n", "<leader>/", "<cmd>call VSCodeNotify('editor.action.commentLine')<CR>", opts)
keymap("x", "<leader>/", "<cmd>call VSCodeNotify('editor.action.commentLine')<CR>", opts)
keymap("n", "<leader>\\", "<cmd>call VSCodeNotify('editor.action.blockComment')<CR>", opts)
keymap("x", "<leader>\\", "<cmd>call VSCodeNotify('editor.action.blockComment')<CR>", opts)


-- vscode multi cursor
vim.keymap.set('n', '<C-l>', 'mciw*<Cmd>nohl<CR>', { remap = true })

-- local C = require 'vscode-multi-cursor'
-- vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
--   require("vscode-multi-cursor").addSelectionToNextFindMatch()
-- end)

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>o', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>O', '<Plug>(leap-backward)')
-- vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

-- rename
vim.keymap.set("n", "<leader>er", "<cmd>call VSCodeNotify('editor.action.rename')<CR>")
vim.keymap.set("n", "<leader>d", "<cmd>call VSCodeNotify('editor.action.addSelectionToNextFindMatch')<CR>")
vim.keymap.set("n", "<leader>D", "<cmd>call VSCodeNotify('editor.action.addSelectionToPrevFindMatch')<CR>")

-- jump to next error / warning
vim.keymap.set("n", "<leader>ee", "<cmd>call VSCodeNotify('go-to-next-error.next.error')<CR>")
vim.keymap.set("n", "<leader>eE", "<cmd>call VSCodeNotify('go-to-next-error.prev.error')<CR>")
vim.keymap.set("n", "<leader>ew", "<cmd>call VSCodeNotify('go-to-next-error.next.warning')<CR>")
vim.keymap.set("n", "<leader>eW", "<cmd>call VSCodeNotify('go-to-next-error.prev.warning')<CR>")
-- same but in all files
vim.keymap.set("n", "<leader>Ee", "<cmd>call VSCodeNotify('go-to-next-error.nextInFiles.error')<CR>")
vim.keymap.set("n", "<leader>EE", "<cmd>call VSCodeNotify('go-to-next-error.prevInFiles.error')<CR>")
vim.keymap.set("n", "<leader>Ew", "<cmd>call VSCodeNotify('go-to-next-error.nextInFiles.warning')<CR>")
vim.keymap.set("n", "<leader>EW", "<cmd>call VSCodeNotify('go-to-next-error.prevInFiles.warning')<CR>")

-- TODO: put these in normal vim config, harpoon is amazing
-- harpoon
vim.keymap.set("n", "<leader>ae", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor')<CR>")
vim.keymap.set("n", "<leader>el", "<cmd>call VSCodeNotify('vscode-harpoon.editEditors')<CR>")
vim.keymap.set("n", "<leader>pe", "<cmd>call VSCodeNotify('vscode-harpoon.editorQuickPick')<CR>")

vim.keymap.set("n", "<leader>1", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor1')<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor2')<CR>")
vim.keymap.set("n", "<leader>3", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor3')<CR>")
vim.keymap.set("n", "<leader>4", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor4')<CR>")
vim.keymap.set("n", "<leader>5", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor5')<CR>")
vim.keymap.set("n", "<leader>6", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor6')<CR>")
vim.keymap.set("n", "<leader>7", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor7')<CR>")
vim.keymap.set("n", "<leader>8", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor8')<CR>")
vim.keymap.set("n", "<leader>9", "<cmd>call VSCodeNotify('vscode-harpoon.gotoEditor9')<CR>")

vim.keymap.set("n", "<leader>a1", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor1')<CR>")
vim.keymap.set("n", "<leader>a2", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor2')<CR>")
vim.keymap.set("n", "<leader>a3", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor3')<CR>")
vim.keymap.set("n", "<leader>a4", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor4')<CR>")
vim.keymap.set("n", "<leader>a5", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor5')<CR>")
vim.keymap.set("n", "<leader>a6", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor6')<CR>")
vim.keymap.set("n", "<leader>a7", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor7')<CR>")
vim.keymap.set("n", "<leader>a8", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor8')<CR>")
vim.keymap.set("n", "<leader>a9", "<cmd>call VSCodeNotify('vscode-harpoon.addEditor9')<CR>")


-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
if vim.g.vscode then
  vim.api.nvim_command([[
    augroup LineNumberManagementVscode
    autocmd InsertEnter * call VSCodeNotify('settings.cycle.lineNumbersOn')
    autocmd InsertLeave * call VSCodeNotify('settings.cycle.lineNumbersRelative')
  augroup END
]])
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Highlight when yanking (copying) text',
--   group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  {
    "kylechui/nvim-surround",
    -- tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- {
  --   'vscode-neovim/vscode-multi-cursor.nvim',
  --   event = 'VeryLazy',
  --   cond = not not vim.g.vscode,
  --   opts = {},
  -- },
  {
    'ggandor/leap.nvim'
  }
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
