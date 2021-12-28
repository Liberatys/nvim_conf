local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local themes = require("telescope.themes")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["esc"] = actions.close,
      },
      n = {
        ["<c-t>"] = trouble.open_with_trouble,
        ["esc"] = actions.close
      },
    },
    prompt_prefix = "λ ",
    theme = 'ivy',
    file_ignore_patterns = {
      "*.lock"
    },
  },
  extensions = {
    fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
    }
  },
}

telescope.load_extension('fzy_native')
