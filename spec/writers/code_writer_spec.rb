RSpec.describe NvimConf::Writers::Code::Orchestrator do
  describe "#aggregate_writes" do
    context "when format is lua" do
      before do
        NvimConf::Core.define do
          settings do
            set :tabstop, 4
            set :tabstop
            set :tabstop
            unset :tabstop
            set :tabstop, scope: :buffer
          end

          plugins(:packer, bootstraped: true) do
            plug("wbthomason/packer.nvim")
            plug("andymass/vim-matchup")
          end

          mappings do
            map "<CTRL-c>", ":MarkdownPreview<CR>"
            nmap "<CTRL-c>", ":MarkdownPreview<CR>"
            imap "<CTRL-c>", ":MarkdownPreview<CR>"
          end
        end
      end

      context "without leading comment" do
        it "writes the settings code to the IO device" do
          io_device = StringIO.new
          described_class.new(
            NvimConf.managers,
            io_device
          ).aggregate_writes

          expected_result = <<~RESULT
            vim.o.tabstop = 4
            vim.o.tabstop = true
            vim.o.tabstop = true
            vim.o.tabstop = false
            vim.bo.tabstop = true


            local fn = vim.fn
            local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
            if fn.empty(fn.glob(install_path)) > 0 then
              packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
            end

            return require('packer').startup(function()
              use 'wbthomason/packer.nvim'
              use 'andymass/vim-matchup'

              if packer_bootstrap then
                require('packer').sync()
              end

            end)


            vim.api.nvim_set_keymap('', '<CTRL-c>', ':MarkdownPreview<CR>')
            vim.api.nvim_set_keymap('n', '<CTRL-c>', ':MarkdownPreview<CR>')
            vim.api.nvim_set_keymap('i', '<CTRL-c>', ':MarkdownPreview<CR>')
          RESULT

          expect(
            io_device.string
          ).to eq(
            expected_result
          )
        end
      end
    end

    context "when format is vim" do
      before do
        NvimConf::Core.define do
          settings do
            set :tabstop, 4
            set :tabstop
            set :tabstop
            unset :tabstop
            set :tabstop, scope: :buffer
          end

          configuration do
            output_folder "$HOME/.config"
            code_output :lua
            documented true
            commented
          end

          mappings do
            map "<CTRL-c>", ":MarkdownPreview<CR>"
            nmap "<CTRL-c>", ":MarkdownPreview<CR>"
            imap "<CTRL-c>", ":MarkdownPreview<CR>"
          end
        end
      end

      it "writes the settings code to the IO device" do
        io_device = StringIO.new
        described_class.new(
          NvimConf.managers,
          io_device,
          {format: :vim, commented: false}
        ).aggregate_writes

        expected_result = <<~RESULT
          set tabstop = 4
          set tabstop
          set tabstop
          set tabstop!
          set tabstop


          map <CTRL-c> :MarkdownPreview<CR>
          nmap <CTRL-c> :MarkdownPreview<CR>
          imap <CTRL-c> :MarkdownPreview<CR>
        RESULT

        expect(
          io_device.string
        ).to eq(
          expected_result
        )
      end
    end
  end
end
