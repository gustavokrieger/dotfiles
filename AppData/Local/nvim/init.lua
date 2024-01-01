if not vim.g.vscode then
    -- bootstrap lazy.nvim, LazyVim and your plugins
    require("config.lazy")
    return
end

-- options
local function default(accessor, option)
    accessor[option] = vim.api.nvim_get_option_info2(option, {}).default
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

default(opt, 'autowrite')
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.ignorecase = true         -- Ignore case
opt.smartcase = true          -- Don't ignore case with capitals

-- keymaps
local map = vim.keymap.set
local call = require('vscode-neovim').call

map('n', ']d', function() call('editor.action.marker.next') end)
map('n', '[d', function() call('editor.action.marker.prev') end)

-- treesitter
map({ 'n', 'x' }, '<C-Space>', function() call('editor.action.smartSelect.expand') end)
map('x', '<bs>', function() call('editor.action.smartSelect.shrink') end)

-- editor
map('n', '<leader>e', function() call('workbench.files.action.showActiveFileInExplorer') end)
map('n', '<leader>,', function() call('workbench.action.showAllEditorsByMostRecentlyUsed') end)
map('n', '<leader>/', function() call('workbench.action.findInFiles') end)
map('n', '<leader><space>', function() call('workbench.action.quickOpen') end)
map('n', '<leader>sk', function() call('workbench.action.showCommands') end)
map('n', '<leader>ss', function() call('breadcrumbs.focusAndSelect') end)
map('n', ']h', function() call('workbench.action.editor.nextChange') end)
map('n', '[h', function() call('workbench.action.editor.previousChange') end)

-- lsp
map('n', 'gr', function() call('editor.action.goToReferences') end)
map('n', 'gD', function() call('editor.action.revealDeclaration') end)
map('n', 'gI', function() call('editor.action.goToImplementation') end)
map('n', 'gy', function() call('editor.action.goToTypeDefinition') end)
map({ 'n', 'v' }, '<leader>ca', function() call('editor.action.quickFix') end)
map('n', '<leader>cr', function() call('editor.action.rename') end)

--- HELIX ---

-- configuration
-- vim.o.ignorecase = true
-- vim.o.smartcase = true
-- vim.g.mapleader = ' '

-- changes
-- vim.keymap.set({ 'n', 'v' }, '<A-d>', '"_d')
-- vim.keymap.set({ 'n', 'v' }, '<A-c>', '"_c')

-- space
-- vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
-- vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
-- vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')

-- quick-scope
-- vim.cmd("let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']")

-- local vscode = require('vscode-neovim')

-- selection manipulation
-- vim.keymap.set({ 'n', 'v' }, '<C-c>', function() vscode.call('editor.action.commentLine') end)
-- vim.keymap.set({ 'n', 'v' }, '<A-o>', function() vscode.call('editor.action.smartSelect.expand') end)
-- vim.keymap.set({ 'n', 'v' }, '<A-i>', function() vscode.call('editor.action.smartSelect.shrink') end)

-- goto
-- vim.keymap.set({ 'n', 'v' }, 'gD', function() vscode.call('editor.action.revealDeclaration') end)
-- vim.keymap.set({ 'n', 'v' }, 'gy', function() vscode.call('editor.action.goToTypeDefinition') end)
-- vim.keymap.set({ 'n', 'v' }, 'gr', function() vscode.call('editor.action.referenceSearch.trigger') end)
-- vim.keymap.set({ 'n', 'v' }, 'gI', function() vscode.call('editor.action.goToImplementation') end)

-- space
-- vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vscode.call('workbench.action.quickOpen') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>b', function() vscode.call('workbench.action.showAllEditorsByMostRecentlyUsed') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>s', function() vscode.call('breadcrumbs.focusAndSelect') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>r', function() vscode.call('editor.action.rename') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>a', function() vscode.call('editor.action.quickFix') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>/', function() vscode.call('workbench.action.findInFiles') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>?', function() vscode.call('workbench.action.showCommands') end)
-- vim.keymap.set({ 'n', 'v' }, '<leader>e', function() vscode.call('workbench.files.action.showActiveFileInExplorer') end)

-- unimpaired
-- vim.keymap.set({ 'n', 'v' }, ']d', function() vscode.call('editor.action.marker.next') end)
-- vim.keymap.set({ 'n', 'v' }, '[d', function() vscode.call('editor.action.marker.prev') end)
-- vim.keymap.set({ 'n', 'v' }, ']g', function() vscode.call('editor.action.dirtydiff.next') end)
-- vim.keymap.set({ 'n', 'v' }, '[g', function() vscode.call('editor.action.dirtydiff.previous') end)
-- vim.keymap.set({ 'n', 'v' }, '] ', function() vscode.call('editor.action.insertLineAfter') end)
-- vim.keymap.set({ 'n', 'v' }, '[ ', function() vscode.call('editor.action.insertLineBefore') end)

-- quick-scope
-- vim.cmd("highlight QuickScopePrimary guifg='#6cd900' gui=underline ctermfg=155 cterm=underline")
-- vim.cmd("highlight QuickScopeSecondary guifg='#00d9d9' gui=underline ctermfg=81 cterm=underline")
