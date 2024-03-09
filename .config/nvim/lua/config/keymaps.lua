if not vim.g.vscode then
  return
end

local map = vim.keymap.set
local call = require("vscode-neovim").call

map("n", "]d", function()
  call("editor.action.marker.next")
end)
map("n", "[d", function()
  call("editor.action.marker.prev")
end)

-- treesitter
map({ "n", "x" }, "<C-Space>", function()
  call("editor.action.smartSelect.expand")
end)
map("x", "<bs>", function()
  call("editor.action.smartSelect.shrink")
end)

-- editor
map("n", "<leader>e", function()
  call("workbench.files.action.showActiveFileInExplorer")
end)
map("n", "<leader>,", function()
  call("workbench.action.showAllEditorsByMostRecentlyUsed")
end)
map("n", "<leader>/", function()
  call("workbench.action.findInFiles")
end)
map("n", "<leader><space>", function()
  call("workbench.action.quickOpen")
end)
map("n", "<leader>sk", function()
  call("workbench.action.showCommands")
end)
map("n", "<leader>ss", function()
  call("breadcrumbs.focusAndSelect")
end)
map("n", "]h", function()
  call("workbench.action.editor.nextChange")
end)
map("n", "[h", function()
  call("workbench.action.editor.previousChange")
end)

-- lsp
map("n", "gr", function()
  call("editor.action.goToReferences")
end)
map("n", "gD", function()
  call("editor.action.revealDeclaration")
end)
map("n", "gI", function()
  call("editor.action.goToImplementation")
end)
map("n", "gy", function()
  call("editor.action.goToTypeDefinition")
end)
map({ "n", "v" }, "<leader>ca", function()
  call("editor.action.quickFix")
end)
map("n", "<leader>cr", function()
  call("editor.action.rename")
end)
