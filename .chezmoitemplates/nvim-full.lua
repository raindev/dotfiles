-------------
-- plugins --
-------------

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable',
      lazypath,
   })
end
-- add lazy.nvim to runtimepath first
vim.opt.rtp:prepend(lazypath)

-- map leader before any plugins define their mappings
vim.g.mapleader = ' '


local function is_journal_file(path)
   return path:find('journal')
end


require('lazy').setup({
   -- add back the GUI commands: lazy.nvim resets the runtime path controlled
   -- with config.performance.rtp.reset
   'equalsraf/neovim-gui-shim',
   -- language parsers
   {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
         'nvim-treesitter/nvim-treesitter-textobjects',
      },
      main = 'nvim-treesitter.configs',
      build = ':TSUpdate',
      opts = {
         ensure_installed = {
            'bash',
            'c',
            'cpp',
            'css',
            'go',
            'graphql',
            'html',
            'http',
            'java',
            'javascript',
            'json',
            'kotlin',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'rust',
            'scala',
            'sql',
            'swift',
            'toml',
            'vimdoc',
            'xml',
            'yaml',
            'zig',
         },
         -- If TS highlights are not enabled at all, or disabled via `disable` prop,
         -- highlighting will fallback to default Vim syntax highlighting.
         highlight = { enable = true },
         incremental_selection = {
            enable = true,
            keymaps = {
               -- maps in normal mode to init the node/scope selection with space
               init_selection = '\\',
               -- increment to the upper named parent
               node_incremental = '\\',
               -- decrement to the previous node
               node_decremental = '<bs>',
               -- increment to the upper scope (as defined in locals.scm)
               scope_incremental = '<tab>',
            },
         },
         indent = { enable = true }
      }
   },
   -- colorscheme
   { 'projekt0n/github-nvim-theme', name = 'github-theme' },
   -- match system light/dark mode
   {
      'raindev/daybreak.nvim',
      opts = {
         light = 'github_light_default',
         dark = 'github_dark_default',
      }
   },
   -- restrict allowed modeline options
   'ypcrts/securemodelines',
   -- readline style editing keybindings
   'tpope/vim-rsi',
   -- repeat plugin commands with dot
   'tpope/vim-repeat',
   -- highlight and navigate matching text
   'andymass/vim-matchup',
   -- add, change and delete surrounding characters
   'tpope/vim-surround',
   -- insert and step over matching characters
   {
      'windwp/nvim-autopairs',
      event = 'InsertEnter',
      opts = {
         -- use Tree-sitter to find the matching pair
         check_ts = true,
      }
   },
   -- keymap discovery
   {
      'folke/which-key.nvim',
      opts = {}
   },
   -- persistent branching undo history
   'mbbill/undotree',
   -- preserve last session per directory
   {
      'folke/persistence.nvim',
      -- only start session saving when an actual file was opened
      event = 'BufReadPre',
      config = function()
         require('persistence').setup({})
         vim.api.nvim_create_user_command('Load', function()
            require('persistence').load()
         end, { nargs = 0 })
         vim.api.nvim_create_user_command('Last', function()
            require('persistence').load({ last = true })
         end, { nargs = 0 })
      end
   },
   -- navigation
   'christoomey/vim-tmux-navigator',
   'ThePrimeagen/harpoon',
   {
      'rgroli/other.nvim',
      config = function()
         require('other-nvim').setup({
            mappings = {
               'golang'
            }
         })
      end
   },
   -- search
   {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
   },
   -- journalling & notetaking
   {
      'epwalsh/obsidian.nvim',
      version = 'v3.x',
      dependencies = {
         'hrsh7th/nvim-cmp'
      },
      opts = {
         workspaces = {
            {
               name = 'notes',
               path = '~/notes',
               -- customize work notes {{- if .work }}
               overrides = {
                  daily_notes = {
                     folder = 'journal/zalando',
                     -- unique journal note title
                     date_format = '%Y-%m-%dz'
                  }
               },
               -- {{- end }}
            },
         },
         -- create notes in the main dir, also when viewing the journal
         new_notes_location = 'notes_subdir',
         daily_notes = {
            folder = 'journal',
            -- February 1, Thursday
            alias_format = '%A, %B %-d',
         },
         note_id_func = function(title)
            return title
         end,
         disable_frontmatter = true,
      },
      init = function()
         vim.keymap.set('v', '<leader>ol', '<cmd>:ObsidianLink<cr><esc>')
         vim.keymap.set('n', '<leader>ol', 'viW<cmd>:ObsidianLink<cr><esc>')
         vim.keymap.set('n', 'gf', function()
               if require('obsidian').util.cursor_on_markdown_link() then
                  return '<cmd>ObsidianFollowLink<CR>'
               else
                  return 'gf'
               end
            end,
            { noremap = false, expr = true })
         local function journal_next(step)
            local buf_path = vim.api.nvim_buf_get_name(0)
            if not buf_path or buf_path == '' then
               vim.notify('buffer has no path', vim.log.levels.INFO)
               return
            end
            if not is_journal_file(buf_path) then
               vim.notify('not a journal buffer', vim.log.levels.INFO)
               return
            end
            local buf_file = vim.fn.fnamemodify(buf_path, ':t:r')
            local date_pattern = '(%d%d%d%d)%-(%d%d)%-(%d%d)'
            local year, month, day = buf_file:match(date_pattern)
            if not year or not month or not day then
               vim.notify('unexpected journal file format: ' .. buf_path, vim.log.levels.INFO)
               return
            end
            local curr_date = os.time({ year = year, month = month, day = day })
            for i = 1, 30 do -- only look for files within a month
               local next_date = os.date('%Y-%m-%d', curr_date + i * step * 24 * 3600)
               local next_file = buf_path:gsub(date_pattern, next_date)
               if vim.loop.fs_stat(next_file) then
                  vim.cmd('edit ' .. next_file)
                  return
               end
            end
            vim.notify('no more close journal files', vim.log.levels.INFO)
         end
         vim.keymap.set('n', '<leader>j;', function()
            journal_next(1)
         end, { desc = 'Open next journal file' })
         vim.keymap.set('n', '<leader>j,', function()
            journal_next(-1)
         end, { desc = 'Open previous journal file' })
      end
   },
   -- startup screen
   {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      opts = function()
         local opts = {
            theme = 'doom',
            config = {
               week_header = {
                  enable = true
               },
               -- stylua: ignore
               center = {
                  { action = 'cd ~/notes | ObsidianToday', desc = ' Today\'s journal', icon = '󰢧 ', key = 't' },
                  { action = 'Telescope find_files', desc = ' Find file', icon = ' ', key = 'f' },
                  { action = 'ene | startinsert', desc = ' New file', icon = ' ', key = 'n' },
                  { action = 'Telescope oldfiles', desc = ' Recent files', icon = ' ', key = 'r' },
                  { action = 'Telescope live_grep', desc = ' Find text', icon = ' ', key = 'g' },
                  { action = 'edit ~/.config/nvim/init.lua', desc = ' Config', icon = ' ', key = 'c' },
                  { action = 'lua require("persistence").load()', desc = ' Load Session', icon = ' ', key = 's' },
                  {
                     action = 'lua require("persistence").load({last = true})',
                     desc = ' Last Session',
                     icon = '󰼛 ',
                     key = 'l'
                  },
                  { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
               },
            }
         }

         -- close Lazy and re-open when the dashboard is ready
         if vim.o.filetype == 'lazy' then
            vim.cmd.close()
            vim.api.nvim_create_autocmd('User', {
               pattern = 'DashboardLoaded',
               callback = function()
                  require('lazy').show()
               end,
            })
         end

         return opts
      end,
      dependencies = { { 'nvim-tree/nvim-web-devicons' } }
   },
   {
      'numToStr/Comment.nvim',
      -- todo: map Ctrl-/ (<C-_>) for line comments
      opts = {},
      lazy = false,
   },
   -- persistent fast access terminal
   {
      'akinsho/toggleterm.nvim',
      config = function()
         require('toggleterm').setup({
            open_mapping = [[<a-;>]],
         })
      end
   },
   -- Git interface
   'tpope/vim-fugitive',
   -- inline Git interface
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

            -- navigation
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

            -- actions
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

            -- text object
            map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
         end
      }
   },
   {
      'stevearc/oil.nvim',
      config = true,
      dependencies = { 'nvim-tree/nvim-web-devicons' },
   },
   -- HTTP client
   {
      'vhyrro/luarocks.nvim',
      priority = 1000,
      config = true,
   },
   {
      'rest-nvim/rest.nvim',
      ft = 'http',
      dependencies = { 'luarocks.nvim' },
      config = function()
         require('rest-nvim').setup({
            keybinds = {
               { '<localleader>rr', '<cmd>:Rest run<cr>',      'Run request under the cursor', },
               { '<localleader>rl', '<cmd>:Rest run last<cr>', 'Re-run latest request', },
            }
         })
      end,
   },
   -- refactoring tools
   {
      'ThePrimeagen/refactoring.nvim',
      dependencies = {
         'nvim-lua/plenary.nvim',
         'nvim-treesitter/nvim-treesitter',
      },
      config = true,
   },
   -- linter integration
   {
      'mfussenegger/nvim-lint',
      config = function()
         require('lint').linters_by_ft = {
            go = { 'golangcilint' }
         }
      end
   },
   -- testing
   {
      'nvim-neotest/neotest',
      dependencies = {
         'nvim-neotest/nvim-nio',
         'nvim-lua/plenary.nvim',
         'antoinemadec/FixCursorHold.nvim',
         'nvim-neotest/neotest-go'
      },
      config = function()
         require('neotest').setup({
            adapters = {
               require('neotest-go')
            }
         })
      end
   },
   -- debugging
   {
      'rcarriga/nvim-dap-ui',
      dependencies = {
         'mfussenegger/nvim-dap',
         'nvim-neotest/nvim-nio'
      },
      config = true
   },
   {
      'leoluz/nvim-dap-go',
      config = true
   },
   {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
         require('nvim-dap-virtual-text').setup({ commented = true })
      end
   },
   -- LSP configuration & servers, completion, snippets
   {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      dependencies = {
         -- LSP Support
         { 'neovim/nvim-lspconfig' },
         { 'williamboman/mason.nvim', },
         { 'williamboman/mason-lspconfig.nvim' },

         -- autocompletion
         { 'hrsh7th/nvim-cmp' },
         { 'hrsh7th/cmp-nvim-lsp' },
         { 'L3MON4D3/LuaSnip' },
         { 'saadparwaiz1/cmp_luasnip' },
         { 'honza/vim-snippets' },
      },
      config = function()
         local lsp_zero = require('lsp-zero')
         lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({
               buffer = bufnr,
               -- lsp-zero thinks which-key already taken all the mappings
               preserve_mappings = false
            })

            -- buffer local mappings.
            local opts = { buffer = bufnr }

            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.keymap.set('n', '<leader>v', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
            vim.keymap.set('n', '<leader>s', '<cmd>belowright split | lua vim.lsp.buf.definition()<CR>', opts)

            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
         end)
         lsp_zero.format_on_save({
            servers = {
               ['gopls'] = { 'go' },
               ['lua_ls'] = { 'lua' },
            }
         })

         require('mason').setup({})
         require('mason-lspconfig').setup({
            ensure_installed = {
               'bashls',
               -- clangd does not support arm64 {{- if ne .hostname "pi4" }}
               'clangd',
               -- {{- end }}
               'jdtls',
               'gopls',
               'lua_ls',
               'rust_analyzer',
               'zls',
            },
            handlers = {
               lsp_zero.default_setup,
               lua_ls = function()
                  local lua_opts = lsp_zero.nvim_lua_ls()
                  require('lspconfig').lua_ls.setup(lua_opts)
               end,
            }
         })

         require('luasnip.loaders.from_snipmate').lazy_load()
         local luasnip = require('luasnip')
         local cmp = require('cmp')
         cmp.setup({
            snippet = {
               expand = function(args)
                  require('luasnip').lsp_expand(args.body)
               end
            },
            sources = {
               { name = 'nvim_lsp' },
               { name = 'luasnip' },
            },
            mapping = cmp.mapping.preset.insert({
               ['<C-y>'] = cmp.mapping.confirm({ select = true }),
               ['<CR>'] = cmp.mapping.confirm({ select = false }),
               -- Allow to jump over snippet placeholders with Tab, but also to use
               -- Tab normally when nor the completion nor a snippet is active.
               ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  elseif luasnip.expand_or_locally_jumpable() then
                     luasnip.expand_or_jump()
                  else
                     fallback()
                  end
               end, { 'i', 's' }),
               ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  elseif luasnip.jumpable(-1) then
                     luasnip.jump(-1)
                  else
                     fallback()
                  end
               end, { 'i', 's' }),
            })
         })
      end
   },
   -- programming language specific plugins
   'fatih/vim-go',
   'ziglang/zig.vim',
   'rust-lang/rust.vim',
   'keith/swift.vim',
   'udalov/kotlin-vim',
}, {
   dev = {
      path = '~/code',
      patterns = { 'raindev' },
      fallback = true,
   },
})

-------------
-- options --
-------------

-- enable true color support
vim.opt.termguicolors = true

-- render tabs as 4 spaces
vim.opt.tabstop = 4
-- insert 4 spaces for a tab
vim.opt.softtabstop = 4
-- insert 4 spaces for an indent
vim.opt.shiftwidth = 4
-- replace each 8 spaces by a tab
vim.opt.expandtab = false

-- use space as vertical split character
vim.opt.fillchars:append('vert: ')
-- show trailing characters, tabs and non-breakable spaces
vim.opt.list = true
vim.opt.listchars:append('tab:  ')
vim.opt.listchars:append('trail:·')
vim.opt.listchars:append('nbsp:⍽')
-- show when line continues outside of screen
vim.opt.listchars:append('extends:»')
vim.opt.listchars:append('precedes:«')
-- indent wrapped lines
vim.opt.breakindent = true
-- show marker for wrapped lines
vim.opt.showbreak = '↳ '
-- before indented text; shift lists to keep alignment
vim.opt.breakindentopt = 'sbr,list:2'
-- in the number column
vim.opt.cpoptions:append('n')
-- conceal syntax (e.g. Markdown), but not completely (highlight code block marks)
vim.opt.conceallevel = 1
-- display line numbers
vim.opt.number = true
-- highlight the line number for the current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- always display the line info column to avoid jumping
vim.opt.signcolumn = 'yes'
-- open folds by default
vim.opt.foldlevelstart = 99

-- do not highlight search results by default
vim.opt.hlsearch = false
-- autocomplete to the longest commons string and than cycle through the
-- alternatives
vim.opt.wildmode = 'longest:full,full'

-- keep backup if file is overwritten
vim.opt.backup = true
-- make a copy to create a backup, overwrite the original file in place
-- this preserves the file creation timestamp (birthtime)
vim.opt.backupcopy = 'yes'
-- create backupdir if doens't exist
local backup_dir = vim.env.HOME .. '/.cache/nvim/backup'
if vim.fn.isdirectory(backup_dir) ~= 1 then
   vim.fn.mkdir(backup_dir)
end
-- save all backups in one place rather than in .
vim.opt.backupdir = backup_dir
-- persist undo history
vim.opt.undofile = true

------------
-- keymap --
------------

-- Empty string is an equivalent of :map, which applies to
-- normal, visual, select and operator-pending mode.

-- toggle highlights
vim.keymap.set('', '<leader>Th', '<cmd>set hlsearch!<CR>', { desc = '[T]oggle [S]earch highlighting' })
vim.keymap.set('', '<leader>Ts', '<cmd>set spell!<CR>', { desc = '[T]oggle [S]pellchecking' })

-- save the pinky
vim.keymap.set('', '<leader>;', ':', { desc = 'Normal mode without shift' })

-- window splits
vim.keymap.set('', '<leader>-', vim.cmd.split, { desc = 'Split window horizontally' })
-- todo: consider a more ergonomic map
vim.keymap.set('', '<leader>\\', vim.cmd.vsplit, { desc = 'Split window vertically' })

-- system clipboard interactions
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank into clipboard' })
vim.keymap.set('n', '<leader>Y', [["+y$]], { desc = '[Y]ank tail of line into clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = '[P]aste from clipboard' })
vim.keymap.set('n', '<leader>P', [["+P]], { desc = '[P]aste from clipboard before cursor' })

-- quickfix list navigation
vim.keymap.set('n', ']q', ':cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', ':cprev<CR>', { desc = 'Previous quickfix item' })

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>F', vim.cmd.Telescope, { desc = '[F]ind stuff' })
vim.keymap.set('n', '<leader>f<space>', telescope.resume, { desc = 'Resume [F]ind' })
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = '[F]ind with [G]rep' })
vim.keymap.set('n', '<leader>fs', telescope.grep_string, { desc = '[F]ind [S]tring' })
vim.keymap.set('n', '<leader>fk', telescope.keymaps, { desc = '[F]ind [K]ey mapping' })
vim.keymap.set('n', '<leader>fr', telescope.oldfiles, { desc = '[f]ind [r]ecent files' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = '[F]ind [H]elp' })

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
vim.keymap.set('', '<leader>A', harpoon_mark.add_file, { desc = '[A]dd to Harpoon file list' })
vim.keymap.set('', '<leader>H', harpoon_ui.toggle_quick_menu, { desc = 'Toggle Harpoon file selector' })
for i = 1, 5 do
   vim.keymap.set('', '<leader>' .. i, function() harpoon_ui.nav_file(i) end, { desc = 'Switch to Harpoon file ' .. i })
end

vim.keymap.set('', '<leader>jt', '<cmd>:ObsidianToday<cr>', { desc = '[J]ournal for [T]oday' })
-- navigate to the previous workday on work laptop {{- if not .work }}
vim.keymap.set('', '<leader>jm', '<cmd>:ObsidianToday 1<cr>', { desc = '[J]ournal for To[M]orrow' })
vim.keymap.set('', '<leader>jy', '<cmd>:ObsidianToday -1<cr>', { desc = '[J]ournal for [Y]esterday' })
-- and to the previous calendar day on private machines {{- else }}
vim.keymap.set('', '<leader>jm', '<cmd>:ObsidianTomorrow<cr>', { desc = '[J]ournal for To[M]orrow' })
vim.keymap.set('', '<leader>jy', '<cmd>:ObsidianYesterday<cr>', { desc = '[J]ournal for [Y]esterday' })
-- {{- end }}

vim.keymap.set('', '<leader>O', '<cmd>:Other<cr>', { desc = 'Open the [O]ther file' })
vim.keymap.set('', '<leader>ts', require('neotest').summary.toggle, { desc = '[t]ests [s]ummary' })
vim.keymap.set('', '<leader>tt', require('neotest').run.run, { desc = 'Run nearest [t]est' })
vim.keymap.set('', '<leader>tl', function() require('neotest').run.run_last() end, { desc = 'Run nearest [t]est' })
vim.keymap.set('', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end,
   { desc = 'Run all test in [f]ile' })
vim.keymap.set('', '<leader>td', function() require('neotest').run.run('.') end,
   { desc = 'Run all tests in [d]irectory' })
vim.keymap.set('', '<leader>tD', function() require('neotest').run.run({ strategy = 'dap' }) end,
   { desc = '[D]ebug nearest test' })
vim.keymap.set('', '<leader>to', require('neotest').output_panel.toggle, { desc = 'Toggle [o]utput panel' })
vim.keymap.set('', '<leader>tw', require('neotest').watch.toggle, { desc = 'Toggle [w]atch mode' })

vim.keymap.set('', '<leader>D',
   function()
      local dap = require('dap')
      if dap.status() == '' then
         dap.continue()
      end
      require('dapui').toggle()
   end,
   { desc = 'Toggle [D]ebugging UI' })
vim.keymap.set('', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Toggle [D]ebugger [B]reakpoint' })

vim.keymap.set('x', '<leader>re', ':Refactor extract ')
vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ')
vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')
vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var')
vim.keymap.set('n', '<leader>rI', ':Refactor inline_func')
vim.keymap.set('n', '<leader>rb', ':Refactor extract_block')
vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file')
vim.keymap.set(
   { 'n', 'x' },
   '<leader>rr',
   function() require('refactoring').select_refactor() end
)
vim.keymap.set(
   'n',
   '<leader>rp',
   function() require('refactoring').debug.printf({ below = false }) end
)
vim.keymap.set({ 'x', 'n' }, '<leader>rv', function() require('refactoring').debug.print_var() end)
vim.keymap.set('n', '<leader>rc', function() require('refactoring').debug.cleanup({}) end)

vim.keymap.set('', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Toggle [U] undo tree' })
vim.keymap.set('', '<leader>w', '<cmd>:write<cr>', { desc = '[W]rite current buffer' })
vim.keymap.set('', '<leader>q', '<cmd>:confirm quitall<cr>', { desc = '[Q]uit with confirmation' })
vim.keymap.set('', '<C-w>go', '<cmd>:tabonly<cr>')

------------------
-- autocommands --
------------------

local augroup = vim.api.nvim_create_augroup('init', {})

-- strip trailing whitespace on write
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
   group = augroup,
   pattern = '*',
   command = [[%s/\s\+$//e]],
})

-- run linters on write
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
   group = augroup,
   callback = function()
      require('lint').try_lint()
   end,
})

---------------
-- filetypes --
---------------

vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'gitcommit' },
   callback = function()
      vim.opt_local.spell = true
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'go' },
   callback = function()
      vim.opt_local.expandtab = false
      vim.opt.tabstop = 8
      vim.opt.shiftwidth = 8
      -- Workaround for the lack of a DAP strategy in neotest-go: https://github.com/nvim-neotest/neotest-go/issues/12
      vim.api.nvim_buf_set_keymap(0, '', '<leader>tD', '<cmd>lua require("dap-go").debug_test()<cr>', {})
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'html' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'java' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 4
      vim.opt_local.shiftwidth = 4
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'kotlin' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'lua' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 3
      vim.opt_local.shiftwidth = 3
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'markdown' },
   callback = function()
      vim.opt_local.spell = true
      vim.opt_local.expandtab = false
      -- visually wrap lines
      vim.opt_local.linebreak = true
      -- hide line break continuation markers
      vim.opt_local.showbreak = 'NONE'
      --- hide line numbers
      vim.opt_local.number = false
      -- swap gj/gk with j/k for finer navigation over wrapped lines
      vim.keymap.set({ 'n', 'v' }, 'j', 'gj', { silent = true, buffer = true })
      vim.keymap.set({ 'n', 'v' }, 'k', 'gk', { silent = true, buffer = true })
      vim.keymap.set({ 'n', 'v' }, 'gj', 'j', { silent = true, buffer = true })
      vim.keymap.set({ 'n', 'v' }, 'gk', 'k', { silent = true, buffer = true })
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'sh' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 4
      vim.opt_local.shiftwidth = 4
   end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
   group = augroup,
   pattern = { 'swift' },
   callback = function()
      vim.opt_local.expandtab = true
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
   end
})

------------------
-- local config --
------------------

local local_init = vim.env.HOME .. '/.config/nvim/init.local.lua'
if vim.fn.filereadable(local_init) ~= 0 then
   dofile(local_init)
end

-- vim: ft=lua
