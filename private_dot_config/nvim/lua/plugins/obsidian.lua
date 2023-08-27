return {
   {
      "epwalsh/obsidian.nvim",
      version = "v1.8.*",
      opts = {
         dir = "~/notes",
         daily_notes = {
            folder = "journals",
         },
         note_id_func = function(title)
            return title
         end,
         disable_frontmatter = true,
      },
      init = function()
         vim.keymap.set("n", "gf", function()
            if require("obsidian").util.cursor_on_markdown_link() then
               return "<cmd>ObsidianFollowLink<CR>"
            else
               return "gf"
            end
         end, { noremap = false, expr = true })
      end,
   },
}
