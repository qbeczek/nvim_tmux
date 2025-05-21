-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- Ogólne ustawienia edytora
-- [[vim.o.number = true -- Włącz numery wierszy
-- vim.o.relativenumber = true -- Relatywne numery wierszy
vim.o.tabstop = 4 -- Szerokość tabulacji
vim.o.shiftwidth = 4 -- Wcięcia
vim.o.expandtab = true -- Używaj spacji zamiast tabulatorów
vim.o.termguicolors = true -- Włącz kolory w terminalu
-- Linia poleceń pod aktywnym oknem
vim.o.cmdheight = 0
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    vim.o.cmdheight = 1
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  callback = function()
    vim.o.cmdheight = 0
  end,
})
-- Przesuwanie linii w górę lub w dół za pomocą Alt + strzałka
vim.keymap.set('n', '<A-Up>', ':m .-2<CR>==', { noremap = true, silent = true }) -- Tryb normalny: przenieś linię w górę
vim.keymap.set('n', '<A-Down>', ':m .+1<CR>==', { noremap = true, silent = true }) -- Tryb normalny: przenieś linię w dół
vim.keymap.set('v', '<A-Up>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true }) -- Tryb wizualny: przenieś zaznaczenie w górę
vim.keymap.set('v', '<A-Down>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true }) -- Tryb wizualny: przenieś zaznaczenie w dół`

vim.o.tabstop = 4
vim.o.shiftwidth = 4
-- 1. Plik explorer: nvim-tree
-- Lazy.nvim setup
return {

  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here

      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = '95%',
            col = '50%',
          },
          size = { width = 60, height = 'auto' },
          border = { style = 'rounded' },
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        --view = { mappings = { list = { { key = '<C-e>', action = 'edit' } } } },
        filters = { dotfiles = false },
        renderer = { icons = { show = { git = true, folder = true, file = true } } },
      }
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end,
  },

  -- 2. Obsługa Git: gitsigns.nvim
  --[[{
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    delete = { text = "_" },
                    change = { text = "~" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local map = vim.keymap.set
                    map("n", "]c", gs.next_hunk, { buffer = bufnr })
                    map("n", "[c", gs.prev_hunk, { buffer = bufnr })
                    map("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
                    map("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr })
                    map("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
                    map("n", "<leader>gd", gs.diffthis, { buffer = bufnr })
                end,
            })
        end,
    },]]

  -- 3. Obsługa kart: barbar.nvim
  {
    'romgrk/barbar.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.keymap.set('n', '<A-1>', ':BufferGoto 1<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-2>', ':BufferGoto 2<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-3>', ':BufferGoto 3<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-4>', ':BufferGoto 4<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-5>', ':BufferGoto 5<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<A-w>', ':BufferClose<CR>', { noremap = true, silent = true })
    end,
  },

  -- 4. Formatowanie kodu: neoformat
  --[[  {
--    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_enabled_c = { 'clangformat' }
      vim.g.neoformat_enabled_cpp = { 'clangformat' }
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.c', '*.cpp' },
        command = 'Neoformat',
      })
      vim.keymap.set('n', '<leader>f', ':Neoformat<CR>', { noremap = true, silent = true })
    end,
  },]]
  -- {
  -- amongst your other plugins
  -- { 'akinsho/toggleterm.nvim', version = '*', config = true },
  -- or
  --{'akinsho/toggleterm.nvim', version = "*", opts = {--[[ things you want to change go here]]}}
  --vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true }),
  --},
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin-mocha',
          icons_enabled = true,
        },
      }
    end,
  },
}
