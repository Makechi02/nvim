return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

        -- configure nvim-tree
        nvimtree.setup({
            view = {
                width = 35,
                relativenumber = true,
            },

            -- change folder arrow icons
            renderer = {
                root_folder_label = false,
                highlight_git = true,

                indent_width = 2,
                indent_markers = {
                    enable = true,
                },

                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "", -- arrow when folder is closed
                            arrow_open = "", -- arrow when folder is open
                        },
                    },
                },
            },

            -- disable window_picker for explorer to work well with window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },

            filters = {
                custom = { ".DS_Store" },
            },

            git = {
                enable = true,
                ignore = false,
            },
        })

        -- SET KEYMAPS --
        local keymap = vim.keymap

        keymap.set({ "n", "x" }, "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set({ "n", "x" }, "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
        keymap.set(
            "n",
            "<leader>ef",
            "<cmd>NvimTreeFindFileToggle<CR>",
            { desc = "Toggle file explorer on current file" }
        )
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end,
}
