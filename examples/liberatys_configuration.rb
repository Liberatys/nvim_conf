require "pathname"

NvimConf::Core.define do
  configuration do
    output_folder "~/.config/nvim"
    code_output :lua
    documented true
    write true
    commented
  end

  commands do
    new(
      "Unset space",
      body: "vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })"
    )

    new(
      "External Commands",
      vim_exec: true,
      body: <<~COMMAND_BODY
        function! ExternalCommandResult()
          return system(input('Command: '))[:-2]
        endfunction

        iabbrev <silent> dsf <C-R>=strftime("%d.%m.%Y")<CR>
      COMMAND_BODY
    )
  end

  commands do
    new(
      "Setup comments per filetype",
      vim_exec: true,
      body: <<~COMMAND_BODY
        augroup commenting_blocks_of_code
          autocmd!
          autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
          autocmd FileType sh,ruby,python   let b:comment_leader = '# '
          autocmd FileType conf,fstab       let b:comment_leader = '# '
          autocmd FileType tex              let b:comment_leader = '% '
          autocmd FileType mail             let b:comment_leader = '> '
          autocmd FileType vim              let b:comment_leader = '" '
        augroup END
      COMMAND_BODY
    )

    new(
      "Force highligh for files",
      vim_exec: true,
      body: <<~COMMAND_BODY
        augroup hightlight_file_type
          autocmd!

          au BufNewFile,BufRead *.exs set filetype=elixir
          au BufNewFile,BufRead *.heex set filetype=elixir
          au BufNewFile,BufRead *.slime set filetype=slim
        augroup END
      COMMAND_BODY
    )
  end

  plugins(:packer, bootstraped: true) do
    # LSP
    plug "dsummersl/nvim-sluice"
    plug "neovim/nvim-lspconfig"
    plug "ray-x/lsp_signature.nvim"
    plug "williamboman/nvim-lsp-installer"
    plug "onsails/lspkind-nvim"

    # Navigation
    plug "pechorin/any-jump.vim"

    # Completion
    plug "hrsh7th/nvim-cmp"
    plug "hrsh7th/cmp-buffer"
    plug "hrsh7th/cmp-path"
    plug "hrsh7th/cmp-nvim-lua"
    plug "hrsh7th/cmp-nvim-lsp"
    plug "tamago324/cmp-zsh"
    plug "f3fora/cmp-spell"

    # Snippets
    plug "L3MON4D3/LuaSnip"
    plug "saadparwaiz1/cmp_luasnip"
    plug "michaelb/sniprun"

    # Languages
    plug "elixir-editors/vim-elixir", file_types: "elixir"
    plug "rust-lang/rust.vim", file_types: "rust"
    plug "vim-ruby/vim-ruby", file_types: "ruby"
    plug "tpope/vim-rails", file_types: "ruby"
    plug "danchoi/ri.vim", file_types: "ruby" # Searcher for ruby lang
    plug "slim-template/vim-slim", file_types: "slim"
    plug "ElmCast/elm-vim", file_types: "elm"

    # Utility
    plug "tpope/vim-dispatch"
    plug "nathom/filetype.nvim"
    plug "lewis6991/impatient.nvim"
    plug "lewis6991/spellsitter.nvim"
    plug "tpope/vim-repeat"
    plug "tpope/vim-abolish"
    plug "tpope/vim-surround"
    plug "qwertologe/nextval.vim"
    plug "nvim-lua/plenary.nvim"
    plug "andymass/vim-matchup"
    plug "ggandor/lightspeed.nvim"
    plug "jiangmiao/auto-pairs"
    plug "lewis6991/gitsigns.nvim"
    plug "nvim-telescope/telescope-fzy-native.nvim"
    plug "nvim-telescope/telescope.nvim"
    plug "luukvbaal/stabilize.nvim"
    plug "nvim-treesitter/nvim-treesitter"
    plug "terrortylor/nvim-comment"

    # Writing
    plug "folke/zen-mode.nvim"

    # Documentation
    plug "skanehira/preview-uml.vim"
    plug "aklt/plantuml-syntax"
    plug "ellisonleao/glow.nvim"

    # Refactoring
    plug "nvim-treesitter/nvim-treesitter-refactor"
    plug "nvim-treesitter/nvim-treesitter-textobjects"
    plug "windwp/nvim-spectre"

    # Testing
    plug "vim-test/vim-test"
    plug "kassio/neoterm"

    # Tabline / Statusline
    plug "folke/trouble.nvim"
    plug "tamton-aquib/staline.nvim"

    # Formating
    plug "sbdchd/neoformat"

    # Linting
    plug "mfussenegger/nvim-lint"

    # UI
    plug "morhetz/gruvbox"
    plug "folke/todo-comments.nvim"
    plug "folke/which-key.nvim"
    plug "kevinhwang91/nvim-hlslens"
    plug "kyazdani42/nvim-web-devicons"
  end

  settings do
    # General
    set :tabstop, 2
    set :colorcolumn, "120"
    set :relativenumber, true
    set :showcmd, true
    set :encoding, "utf-8"
    set :updatetime, 300
    set :timeoutlen, 100
    set :synmaxcol, 200
    set :linebreak, false
    set :bg, "dark"
    set :mmp, 20_000
    set :expandtab, true
    set :shiftwidth, 2
    set :cursorline, true
    set :undofile, true
    set :incsearch, true
    set :number, true
    set :smartcase, true
    # set :completeopt, %w[menu menuone noselect] -> Not working for some reason
    set :pumheight, 0

    %w[
      iwhite
      algorithm:patience
      indent-heuristic
    ].each do |opt_addition|
      add :diffopt, opt_addition, scope: :opt
    end

    add :clipboard, "unnamedplus", scope: :opt
    add :shortmess, "c", scope: :opt

    %w[
      *.o,*.obj,*~
      *.git*
      *sass-cache*
      *logs*
      *node_modules*
      **/node_modules/**
      *DS_Store*
      *.gem
      log/**
      tmp/**
      *.png,*.jpg,*.gif
    ].each do |wildignore_option|
      add :wildignore, wildignore_option, scope: :opt
    end

    # Splits
    set :splitright, true
    set :splitbelow, true
    set :ttyfast, true

    # Commands
    set :cmdheight, 1
    set :history, 50
    set :inccommand, :nosplit

    # Search / Replace
    set :showmatch, true
    set :ignorecase, true

    # Shell
    set :shell, "/bin/zsh"
    set :undodir, Pathname.new("~/.vimdid").expand_path.to_s
  end

  commands do
    new(
      "Init gruvbox",
      body: "colorscheme gruvbox",
      vim_exec: true
    )

    new(
      "Init nvim_comment",
      body: <<~COMMAND_BODY
        require('nvim_comment').setup({
          marker_padding = true,
          comment_empty = true,
          create_mappings = true,
          line_mapping = "gcc",
          operator_mapping = "gc",
          hook = nil
        })
      COMMAND_BODY
    )

    new(
      "Init dev_icons",
      body: <<~COMMAND_BODY
        require "nvim-web-devicons".setup {
            default = true
        }
      COMMAND_BODY
    )

    new(
      "Init lightspeed",
      body: <<~COMMAND_BODY
        require'lightspeed'.setup {
          jump_on_partial_input_safety_timeout = 400,
          highlight_unique_chars = false,
          grey_out_search_area = true,
          match_only_the_start_of_same_char_seqs = true,
          limit_ft_matches = 5,
          substitute_chars = { ['\\r'] = '¬' },
          instant_repeat_fwd_key = nil,
          instant_repeat_bwd_key = nil,
          labels = nil,
          cycle_group_fwd_key = nil,
          cycle_group_bwd_key = nil,
        }
      COMMAND_BODY
    )

    new(
      "Init tabline",
      body: <<~COMMAND_BODY
        require'stabline'.setup {
        	style = "slant",
        	bg = "#986fec",
        	fg = "black",
        	stab_right = ""
        }
      COMMAND_BODY
    )

    new(
      "Init testing",
      vim_exec: true,
      body: <<~COMMAND_BODY
        let test#strategy = "neoterm"
      COMMAND_BODY
    )

    {
      comp: "Init comp.nvim",
      lsp: "Init LSP",
      tab_configuration: "Init Tab Configuration",
      telescope: "Init Telescope",
      treesitter: "Init Treesitter"
    }.each do |key, label|
      path = "#{__dir__}/configuration_parts/init_#{key}.lua"
      new(
        label,
        body: File.read(path)
      )
    end
  end

  requires do
    setup("gitsigns")
    setup("spellsitter")
    setup("staline")
    setup("todo-comments")
    setup("which-key")
  end

  globals do
    set :mapleader, " "
    set :neoformat_basic_format_align, true
    set :neoformat_basic_format_retab, true
    set :neoformat_basic_format_trim, true
    set :did_load_filetypes, 1

    set :ri_no_mappings, true

    %i[
      gzip
      zip
      zipPlugin
      tar
      tarPlugin
      getscript
      getscriptPlugin
      vimball
      vimballPlugin
      2html_plugin
      matchit
      matchparen
      rrhelper
      netrw
      netrwPlugin
      netrwSettings
    ].each do |builtin_setting|
      set "loaded_#{builtin_setting}", true
    end

    set :neoformat_enabled_ruby, ["rubocop"]
  end

  mappings do
    map "<c-c>", "<ESC>"
    map "jk", "<ESC>"
    nmap ";", ":"
    vmap ";", ":"

    # Disable arrow keys
    map "<UP>", "<ESC>"
    map "<DOWN>", "<ESC>"
    map "<LEFT>", "<ESC>"
    map "<RIGTH>", "<ESC>"

    # tmap '<ESC>', '<C-\><C-n>'
    # nmap '<leader>ni', ':e $NOTE_INDEX/index.md<CR>:cd $NOTE_INDEX<CR>'

    map "<Leader>rk", ":call ri#LookupNameUnderCursor()<CR>"
  end

  mappings do
    map "F", "^"
    map "T", "$"

    map "n", "nzz"
    map "N", "Nzz"
    map "*", "*zz"
    map "#", "#zz"
    map "g#", "g*zz"

    vmap "<TAB>", ">gv"
    vmap "<S-TAB>", "<gv"

    nmap "<S-k>", "mz:m-2<cr>`z"
    nmap "<S-j>", "mz:m+<cr>`z"
    vmap "<S-j>", ":m'>+<cr>`<my`>mzgv`yo`z"
    vmap "<S-k>", ":m'<-2<cr>`>my`<mzgv`yo`z"
  end

  mappings do
    nmap "<C-J>", "<C-W><C-J>"
    nmap "<C-K>", "<C-W><C-K>"
    nmap "<C-H>", "<C-W><C-H>"
    nmap "<c-s>", ":w<CR>"
  end
end
