return {
    "aaronik/treewalker.nvim",
    opts = {
        highlight = true,         -- Whether to briefly highlight the node after jumping to it
        highlight_duration = 250, -- How long should above highlight last (in ms)
    },
    config = function()
        vim.api.nvim_set_keymap('n', '<C-j>', ':Treewalker Down<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<C-k>', ':Treewalker Up<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<C-h>', ':Treewalker Left<CR>', { noremap = true })
        vim.api.nvim_set_keymap('n', '<C-l>', ':Treewalker Right<CR>', { noremap = true })
    end
}
