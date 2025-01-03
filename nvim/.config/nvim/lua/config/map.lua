vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Execute line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute selected" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Oil" })
vim.keymap.set("n", "<leader>bx", "<cmd>:w | %bd | e#<CR>", { desc = "Close all buffers except current" })
vim.keymap.set("n", "<leader>bW", "<cmd>:w !sudo tee > /dev/null %<CR>", { desc = "Force write" })
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format, { desc = "Format buffer" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("i", "<C-j>", "<down>")
vim.keymap.set("i", "<C-k>", "<up>")
vim.keymap.set("i", "<C-l>", "<right>")

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<S-up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<S-down>", '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set({ "n", "i" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')
-- vim.keymap.set('n', '<up>', 'gk')
-- vim.keymap.set('n', '<down>', 'gj')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "J", "mzJ`z", { desc = "Append next line to the end of current" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Center first search item" })

vim.keymap.set("x", "<leader>p", "p", { desc = "Yank and paste" })
vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without yanking" })
-- vim.keymap.set({ 'n', 'v' }, '<leader>D', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]], { desc = "Yank line to clipboard" })

vim.keymap.set("n", "<leader>nh", function()
  Snacks.notifier.show_history()
end, { desc = "Show Notification History" })

vim.keymap.set("n", "<leader>oo", ":cd ~/vaults/personal<CR>", { desc = "Vault dir" })
vim.keymap.set(
  "n",
  "<leader>on",
  ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
  { desc = "Note from template" }
)
vim.keymap.set(
  "n",
  "<leader>os",
  ':Telescope find_files search_dirs={"~/vaults/personal/"}<cr>',
  { desc = "File search" }
)
vim.keymap.set(
  "n",
  "<leader>oz",
  ':Telescope live_grep search_dirs={"~/vaults/personal/"}<cr>',
  { desc = "Live grep search" }
)
vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>", { desc = "Format title" })
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete note" })
