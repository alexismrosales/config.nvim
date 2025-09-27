return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'nvim-treesitter/nvim-treesitter', -- for treesitter-based folding
  },
  config = function()
    -- Basic fold settings
    vim.o.foldcolumn = '1' -- Show fold column
    vim.o.foldlevel = 99   -- Open all folds by default
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Treesitter fold method
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

    -- UFO setup
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })
  end
}

