local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lazy.nvim resets the runtime path constrolled with
  -- config.performance.rtp.reset
  'equalsraf/neovim-gui-shim',
  'navarasu/onedark.nvim',
  'tpope/vim-surround',
  'tpope/vim-sleuth',
  'andymass/vim-matchup',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
          map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
  },
  'rust-lang/rust.vim',
  'udalov/kotlin-vim',
  'keith/swift.vim',
  'ziglang/zig.vim',
  { 'nvim-treesitter/nvim-treesitter',
    main = 'nvim-treesitter.configs',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'c',
        'cpp',
        'css',
        'go',
        'html',
        'java',
        'javascript',
        'lua',
        'org',
        'rust',
        'sql',
        'zig'
      },
      -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
      highlight = {
        enable = true,
        disable = { 'org' }, -- Remove this to use TS highlighter for some of the highlights (Experimental)
        additional_vim_regex_highlighting = { 'org' }, -- Required since TS highlighter doesn't support all syntax features (conceal)
      },
    }
  },
  { 'nvim-orgmode/orgmode', config = function()
    local orgmode = require('orgmode')
    orgmode.setup_ts_grammar()
    orgmode.setup({
      org_agenda_files = { '~/notes/*.org' },
      org_default_notes_file = '~/notes/inbox.org',
    })
  end },
  { 'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'epwalsh/obsidian.nvim', version = 'v1.8.*',
    dependencies = {
      'preservim/vim-markdown',
      'hrsh7th/nvim-cmp'
    },
    opts = {
        dir = '~/notes',
        daily_notes = {
          folder = 'journals'
        },
        note_id_func = function(title)
          return title
        end,
        disable_frontmatter = true
      },
    init = function()
      vim.keymap.set('n', 'gf', function()
        if require('obsidian').util.cursor_on_markdown_link() then
          return '<cmd>ObsidianFollowLink<CR>'
        else
          return 'gf'
        end
      end,
      { noremap = false, expr = true})
    end
  },
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'tpope/vim-fugitive',
  'ypcrts/securemodelines',
  { 'raindev/daybreak.nvim', config = true }
},
{
  dev = {
    path = "~/code",
    patterns = { "raindev" },
    fallback = true,
  },
})
