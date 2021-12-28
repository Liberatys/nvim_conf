local vimp = require('vimp')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local map = vim.api.nvim_set_keymap


function default_telescope_action(operation)
  operation(themes.get_ivy({ previewer = false }))
end

vimp.map('<leader>t', ':TestNearest<CR>')
vimp.map('<leader>T', ':TestFile<CR>')
-- vimp.map('<leader>T', ':TestSuite<CR>')
-- vimp.map('<leader>g', ':TestVisit<CR>')

vimp.nnoremap('<leader><leader>', function()
  default_telescope_action(builtin.find_files)
end)

vimp.nnoremap('<C-f>', function()
  default_telescope_action(builtin.git_files)
end)

vimp.nnoremap('<C-m>', function()
  default_telescope_action(builtin.treesitter)
end)

vimp.nnoremap('<C-Q>', function()
  builtin.live_grep()
end)

vimp.nnoremap('<leader>e', function()
  builtin.grep_string()
end)

vimp.nnoremap('<leader>a', function()
  builtin.lsp_code_actions()
end)

vimp.nnoremap('<leader>bb', function()
  builtin.buffers()
end)

vimp.nnoremap('<leader>cc', function()
  builtin.commands()
end)

vimp.nnoremap('<leader>h', function()
  builtin.help_tags()
end)

vimp.nnoremap('<leader>lv', function()
  builtin.registers()
end)

vimp.nnoremap('<silent>gf', function()
  builtin.lsp_definitions()
end)

vimp.nnoremap('<leader>ss', function()
  builtin.spell_suggest()
end)

vimp.nnoremap('<leader>sc', function()
  builtin.current_buffer_fuzzy_find()
end)

vimp.nnoremap('<silent>gd', function()
  builtin.lsp_implementations()
end)

vimp.nnoremap('<C-G>', function()
  builtin.git_commits()
end)

vimp.nnoremap('<leader>S', function()
  require('spectre').open()
end)

vimp.nnoremap('<leader>sp', function()
  require('spectre').open_file_search()
end)
