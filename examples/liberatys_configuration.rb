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
    plug "elixir-editors/vim-elixir"
    plug "rust-lang/rust.vim"
    plug "vim-ruby/vim-ruby"
    plug "tpope/vim-rails"
    plug "danchoi/ri.vim" # Searcher for ruby lang
    plug "slim-template/vim-slim"
    plug "ElmCast/elm-vim"

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
    set :pumheight, 0

    %w[
      iwhite
      algorithm:patience
      indent-heuristic
    ].each do |opt_addition|
      add :diffopt, opt_addition, scope: :opt
    end

    add :clipboard, "unnamedplus", scope: :opt

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
  end

  globals do
    set :mapleader, " "
    set :neoformat_basic_format_align, true
    set :neoformat_basic_format_retab, true
    set :neoformat_basic_format_trim, true

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
