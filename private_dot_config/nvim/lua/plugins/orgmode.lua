return {
   {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
         vim.list_extend(opts.ensure_installed, {
            "cpp",
            "css",
            "go",
            "java",
            "org",
            "rust",
            "sql",
            "zig",
         })
      end,
   },
   {
      "nvim-orgmode/orgmode",
      config = function()
         local orgmode = require("orgmode")
         orgmode.setup_ts_grammar()
         orgmode.setup({
            org_agenda_files = { "~/notes/*.org" },
            org_default_notes_file = "~/notes/inbox.org",
         })
      end,
   },
}
