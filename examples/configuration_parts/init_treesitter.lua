function loadTreeSitterDefs()
  vim.cmd([[
    :TSInstall lua
    :TSInstall ruby
    :TSInstall go
    :TSInstall vim
    :TSInstall scss
    :TSInstall json
    :TSInstall typescript
  ]])
end

require'nvim-treesitter.configs'.setup {
  refactor = {
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    highlight_current_scope = { enable = true },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["<leader>an"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>ap"] = "@parameter.inner",
      },
    },
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
