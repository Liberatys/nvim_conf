NvimConf::Core.define do
  configuration do
    output_folder "~/.config/nvim"
    code_output :lua
    documented true
    write true
    commented
  end

  commands do
    group "Tools" do
      new(
        "Setup impatient",
        body: "require('impatient')"
      )
    end
  end

  plugins(:packer, bootstraped: true) do
    group "Tools" do
      plug "kyazdani42/nvim-web-devicons"
      plug "nvim-lua/plenary.nvim"
      plug "gelguy/wilder.nvim", run: ":UpdateRemotePlugins"
      plug "neovim/nvim-lspconfig"
      plug "lewis6991/impatient.nvim"
      plug "nvim-telescope/telescope-fzf-native.nvim", run: "make"
      plug "farmergreg/vim-lastplace"
      plug "chiedo/vim-case-convert"
      plug "danchoi/ri.vim"
      plug "s1n7ax/nvim-terminal"
    end

    group "Management" do
      plug "ahmedkhalf/project.nvim"
    end

    group "Linting" do
      plug "mfussenegger/nvim-lint"
    end

    group "Formating" do
      plug "mhartington/formatter.nvim"
    end

    group "Utility" do
      plug "folke/which-key.nvim"
      plug "mhinz/vim-startify"
      plug "monaqa/dial.nvim"
      plug "windwp/nvim-autopairs"

      %w[vim-repeat vim-abolish vim-characterize vim-surround].each do |tpope_plugin|
        plug "tpope/#{tpope_plugin}"
      end

      plug "tpope/vim-dispatch", cmd: %w[Dispatch Make]
    end

    group "Testing" do
      plug "vim-test/vim-test" # Foundation
      plug "rcarriga/vim-ultest", run: ":UpdateRemotePlugins"
    end

    group "Syntax" do
      plug "nvim-treesitter/nvim-treesitter", run: ":TSUpdate"
      plug "lewis6991/spellsitter.nvim"
    end

    group "Documentation" do
      plug "davidgranstrom/nvim-markdown-preview"
      plug "nvim-neorg/neorg"
    end

    group "Development" do
      plug "folke/lua-dev.nvim", file_types: "lua"
      plug "is0n/jaq-nvim"
      plug "numToStr/Comment.nvim"
      plug "folke/todo-comments.nvim"
      plug "folke/trouble.nvim"
      plug "windwp/nvim-spectre"
      plug "mfussenegger/nvim-dap"
      plug "rcarriga/nvim-dap-ui"
      plug "theHamsta/nvim-dap-virtual-text"
    end

    group "Development - Languages" do
      plug "ray-x/go.nvim"
      plug "vim-ruby/vim-ruby", file_types: "ruby"
      plug "rust-lang/rust.vim", file_types: "rust"
      plug "elixir-editors/vim-elixir", file_types: "elixir"
      plug "leafgarland/typescript-vim", file_types: "typescript"
      plug "pangloss/vim-javascript", file_types: "javascript"
      plug "elmcast/elm-vim", file_types: "elm"
      plug "slim-template/vim-slim", file_types: "slim"
    end

    group "Completion" do
      plug "ms-jpq/coq_nvim", branch: "coq"
      plug "ms-jpq/coq.artifacts", branch: "artifacts"
      plug "ms-jpq/coq.thirdparty", branch: "3p"
    end

    group "Navigation" do
      plug "chentau/marks.nvim"
      plug "ggandor/lightspeed.nvim"
      plug "nvim-telescope/telescope.nvim"
      plug "ray-x/guihua.lua", run: "cd lua/fzy && make"
      plug "ray-x/navigator.lua"
    end

    group "UI" do
      plug "folke/tokyonight.nvim"
      plug "lewis6991/gitsigns.nvim"
      plug "sindrets/diffview.nvim"
      plug "nvim-lualine/lualine.nvim"
      plug "yamatsum/nvim-cursorline"
      plug "luukvbaal/stabilize.nvim"
    end
  end

  commands do
    group "Telescope" do
      new(
        "Setup telescope",
        body: <<~START
          local actions = require("telescope.actions")

          require("telescope").setup({
              defaults = {
                  mappings = {
                      i = {
                          ["<esc>"] = actions.close,
                      },
                  },
              },
          })
        START
      )
      new(
        "fzf",
        body: "require('telescope').load_extension('fzf')"
      )
    end

    group "Completion" do
      new(
        "Setup autostart for completion",
        body: <<-START
          vim.g.coq_settings = {
            auto_start = 'shut-up',
          }
        START
      )

      new(
        "Setup wilder",
        body: "call wilder#setup({'modes': [':', '/', '?']})",
        vim_exec: true
      )

      new(
        "Setup wilder popup",
        body: "call wilder#set_option('renderer', wilder#popupmenu_renderer({ 'highlighter': wilder#basic_highlighter()}))",
        vim_exec: true
      )
    end

    group "UI" do
      new(
        "Setup theme",
        body: "vim.cmd[[colorscheme tokyonight]]"
      )
    end

    group "Documentation" do
      new(
        "Setup neoorg",
        body: <<~START
          require('neorg').setup {
              -- Tell Neorg what modules to load
              load = {
                  ["core.defaults"] = {},
                  ["core.norg.concealer"] = {}
              },
          }
        START
      )
    end
  end

  settings do
    group "General" do
      set :timeoutlen, 500
      set :updatetime, 500
      set :swapfile, false
      set :cursorline
      set :undodir, Pathname.new("~/.vimdid").expand_path.to_s
      set :undofile
    end

    group "Editing" do
      set :virtualedit, "block"
      set :ignorecase
      set :smartcase
      set :infercase
      set :incsearch
      set :wrapscan
      set :list
      add :shortmess, "c", scope: :opt
      set :wrap, false
      set :spelllang, "en"
      set :clipboard, "unnamedplus"
    end

    group "Editor" do
      set :autowrite
      set :synmaxcol, 200
      set :title
      set :signcolumn, "yes"
      set :encoding, "utf-8"
      set :splitright
      set :splitbelow
      set :cmdheight, 1
      set :cmdwinheight, 5
      set :wildmenu
      add :wildignore, ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif", scope: :opt
      add :wildignore, "*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**", scope: :opt
      set :redrawtime, 1500
      set :hidden
      set :wildignorecase
      set :backup, false
      set :writebackup, false
      set :swapfile, false
    end

    group "Specific" do
      set :lazyredraw
    end

    group "Fold" do
      set :foldmethod, "indent"
      set :foldlevel, 99
      set :foldenable
      set :formatoptions, "qj"
    end

    group "Visual" do
      set :number
      set :relativenumber
      set :termguicolors
      set :tabstop, 4
      set :softtabstop, 4
      set :shiftwidth, 4
      set :expandtab
      set :showmode, false
    end
  end

  globals do
    set :mapleader, " "
    group "Disable builtins" do
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
        logiPat
        rrhelper
        netrw
        netrwPlugin
        netrwSettings
      ].each do |builtin_option|
        set :"loaded_#{builtin_option}", 1
      end
    end
  end

  commands do
    new(
      "Setup linter",
      body: "au BufWritePost <buffer> lua require('lint').try_lint()",
      vim_exec: true
    )

    new(
      "Setup projects",
      body: "require('telescope').load_extension('projects')"
    )
  end

  mappings do
    group "General" do
      map ";", ":"
      map "<C-a>", "<Plug>(dial-increment)"
      map "<C-x>", "<Plug>(dial-decrement)"
    end

    group "Disable Ugly Stuff" do
      map "<Up>", "<Esc>"
      map "<Down>", "<Esc>"
      map "<Left>", "<Esc>"
      map "<Right>", "<Esc>"
    end

    group "Testing" do
      map "<leader>t", ":UltestNearest<CR>"
      map "<leader>to", ":UltestOutput<CR>"
      map "<leader>T", ":UltestSummary<CR>"
    end

    group "Utility" do
      map "<leader>q", ":Trouble<CR>"
      map "<leader>;", ":lua terminal:toggle()<cr>"
    end

    group "Telescope" do
      {
        "<C-f>" => :git_files,
        "<C-m>" => :treesitter,
        "<C-q>" => :live_grep,
        "<leader>e" => :grep_string,
        "<leader>a" => :lsp_code_actions,
        "<leader>bb" => :buffers,
        "<leader>cc" => :commands,
        "<leader>h" => :help_tags,
        "<leader>lv" => :registers,
        "<leader>ss" => :spell_suggest,
        "<C-G>" => :git_commits
      }.each do |mapping, method|
        map mapping, ":lua require('telescope.builtin').#{method}()<CR>"
      end

      map "<leader>F", ":Format<CR>"
      map "<leader>S", ":lua require('spectre').open()<CR>"
      map "<leader>ff", ":vim.lsp.buf.formatting()<CR>"
      map "<leader>p", ":Telescope projects<CR>"
      map "<leader>sp", ":lua require('spectre').open_file_search()<CR>"
    end

    group "Terminal" do
      tmap "<Esc>", '<C-\\><C-n>'
    end

    group "Navigation" do
      map "F", "^"
      map "T", "$"

      map "n", "nzz"
      map "N", "Nzz"
      map "*", "*zz"
      map "#", "#zz"
      map "g#", "g*zz" # What does this do?

      vmap "<TAB>", ">gc"
      vmap "<S-TAB>", "<gc"

      vmap "<S-j>", ":m'>+<cr>`<my`>mzgv`yo`z"
      vmap "<S-k>", ":m'<-2<cr>`>my`<mzgv`yo`z"

      map "<leader>cd", ":cd %:p:h<CR>:pwd<CR>"

      map "<leader>bp", ":bp<CR>"
      map "<leader>bn", ":bn<CR>"
      map "<leader>nh", ":noh<CR>"
    end

    group "Splits" do
      map "vv", "<C-W>v"
      map "ss", "<C-W>s"

      nmap "<C-J>", "<C-W><C-J>"
      nmap "<C-K>", "<C-W><C-K>"
      nmap "<C-H>", "<C-W><C-H>"
      nmap "<c-s>", ":w<CR>"
    end
  end

  requires do
    group "Formating" do
      setup "formatter"
    end

    group "Mangement" do
      setup "project_nvim"
    end

    group "UI" do
      setup "gitsigns"
      setup "diffview"
      setup "lualine"
      setup "stabilize"
    end

    group "Syntax" do
      setup "spellsitter"
    end

    group "Development" do
      setup "jaq-nvim"
      setup "Comment"
      setup "nvim-terminal"
      setup "todo-comments"
      setup "trouble"
      setup "go"
    end

    group "Utility" do
      setup "which-key"
      setup "spectre"
      setup "nvim-autopairs"
    end

    group "Navigation" do
      setup "marks"
      setup "navigator"
    end
  end

  commands do
    group("Formating") do
      new(
        "Setup formatter - Lua",
        body: <<~START
          require('formatter').setup({
              filetype = {
                lua = {
                    -- luafmt
                    function()
                      return {
                        exe = "luafmt",
                        args = {"--indent-count", 2, "--stdin"},
                        stdin = true
                      }
                    end
                },
              }
            })
        START
      )

      new(
        "Setup formatter - clang",
        body: <<~START
          require('formatter').setup({
              filetype = {
                cpp = {
                    -- clang-format
                   function()
                      return {
                        exe = "clang-format",
                        args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                        stdin = true,
                        cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
                      }
                    end
                },
              }
            })
        START
      )

      new(
        "Setup formatter - rust",
        body: <<~START
          require('formatter').setup({
            filetype = {
              rust = {
                -- Rustfmt
                function()
                  return {
                    exe = "rustfmt",
                    args = {"--emit=stdout"},
                    stdin = true
                  }
                end
              },
            }
          })
        START
      )

      new(
        "Setup formatter - ruby",
        body: <<~START
          require('formatter').setup({
            filetype = {
              ruby = {
                 -- rubocop
                 function()
                   return {
                     exe = "rubocop", -- might prepend `bundle exec `
                     args = { '--auto-correct', '--stdin', '%:p', '2>/dev/null', '|', "awk 'f; /^====================$/{f=1}'"},
                     stdin = true,
                   }
                 end
               }
            }
          })
        START
      )
    end
  end
end
