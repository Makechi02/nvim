local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

-- Save key strokes (No need to press shift to enter command mode).
keymap.set({ "n", "x" }, ";", ":")

-- NvimTree
keymap.set({"n", "x"}, "<c-n>", "<cmd>NvimTreeToggle<cr>", {desc = "Toggle NvimTree"})
keymap.set({"n", "x"}, "<leader>e", "<cmd>NvimTreeFocus<cr>", {desc = "Focus NvimTree"})

-- Move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', { desc = "move line up" })
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', { desc = "move line down" })

-- Remove trailing whitespace characters
keymap.set("n", "<leader>,", "<cmd>StripTrailingWhitespace<cr>", { desc = "remove trailing space" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
keymap.set("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
keymap.set("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find Buffers" })
keymap.set("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
keymap.set("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
keymap.set("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })
-- telescope git
keymap.set("n", "<leader>cm", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
keymap.set("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })
-- telescope pick a hidden term
keymap.set("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })
-- telescope theme switcher
keymap.set("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Pick themes" })

keymap.set("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "Telescope bookmarks" })

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

