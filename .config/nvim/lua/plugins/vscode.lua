if not vim.g.vscode then
  return {}
end

local map = vim.keymap.set
local call = require("vscode-neovim").call

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimKeymaps",
  callback = function()
    -- General
    map("n", "<S-h>", function()
      call("workbench.action.previousEditor")
    end)
    map("n", "<S-l>", function()
      call("workbench.action.nextEditor")
    end)
    map("n", "[b", function()
      call("workbench.action.previousEditor")
    end)
    map("n", "]b", function()
      call("workbench.action.nextEditor")
    end)
    map("n", "<leader>cf", function()
      call("editor.action.formatDocument")
    end)
    map("v", "<leader>cf", function()
      call("editor.action.formatSelection")
    end)
    map("n", "]d", function()
      call("editor.action.marker.next")
    end)
    map("n", "[d", function()
      call("editor.action.marker.prev")
    end)
    map("n", "<leader>uw", function()
      call("editor.action.toggleWordWrap")
    end)
    map("n", "<leader>gg", function()
      call("workbench.view.scm")
    end)

    -- LSP
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
    map({ "n", "v" }, "<leader>cc", function()
      call("codelens.showLensesInCurrentLine")
    end)
    map("n", "<leader>cr", function()
      call("editor.action.rename")
    end)

    -- neo-tree.nvim
    map("n", "<leader>e", function()
      call("workbench.files.action.showActiveFileInExplorer")
    end)

    -- nvim-dap
    map("n", "<leader>da", function()
      call("workbench.action.debug.selectandstart")
    end)
    map("n", "<leader>db", function()
      call("editor.debug.action.toggleBreakpoint")
    end)
    map("n", "<leader>dl", function()
      call("workbench.action.debug.restart")
    end)

    -- telescope.nvim
    map("n", "<leader><space>", function()
      call("workbench.action.quickOpen")
    end)
    map("n", "<leader>,", function()
      call("workbench.action.showAllEditorsByMostRecentlyUsed")
    end)
    map("n", "<leader>/", function()
      call("workbench.action.findInFiles")
    end)
    map("n", "<leader>sk", function()
      call("workbench.action.showCommands")
    end)
    map("n", "<leader>ss", function()
      call("workbench.action.gotoSymbol")
    end)

    -- neotest
    map("n", "<leader>tl", function()
      call("testing.reRunLastRun")
    end)
    map("n", "<leader>to", function()
      call("testing.openOutputPeek")
    end)
    map("n", "<leader>tO", function()
      call("workbench.panel.testResults.view.focus")
    end)
    map("n", "<leader>tr", function()
      call("testing.runAtCursor")
    end)
    map("n", "<leader>ts", function()
      call("workbench.view.testing.focus")
    end)
    map("n", "<leader>tt", function()
      call("testing.runCurrentFile")
    end)
    map("n", "<leader>tT", function()
      call("testing.runAll")
    end)

    -- nvim-dap
    map("n", "<leader>td", function()
      call("testing.debugAtCursor")
    end)

    -- gitsigns.nvim
    map("n", "]h", function()
      call("workbench.action.editor.nextChange")
    end)
    map("n", "[h", function()
      call("workbench.action.editor.previousChange")
    end)
    map("n", "<leader>ghp", function()
      call("editor.action.dirtydiff.next")
    end)
    map("n", "<leader>ghd", function()
      call("git.openChange")
    end)

    -- other
    map("n", "<leader>l", function()
      call("workbench.action.chat.open")
    end)
  end,
})

return {}
