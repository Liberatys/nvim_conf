require "fileutils"

RSpec.describe "Complete Write => Lua" do
  let(:path) { Pathname.new("~/.config/nvim_conf/test").expand_path }

  before do
    NvimConf::Core.define do
      settings do
        set "tabstop"
      end

      mappings do
        nmap "<CTRL-c>", ":Git Blame"
      end

      plugins(:packer, bootstraped: true) do
        plug "glacambre/firenvim", opt: true, run: "cd folder"
        plug "glepnir/galaxyline.nvim", opt: true, branch: "main"
      end

      mappings(:nmap) do
        m "<CTRL-c>", ":Git Blame"
        m "<CTRL-c>", ":Git Blame"
      end

      settings do
        set "nvim-linter"
        set "tester"
      end

      configuration do
        output_folder "~/.config/nvim_conf/test"
        code_output :lua
        documented true
        write true
        commented
      end
    end
  end

  after do
    unless ENV["PREVENT_DESTRUCTION"]
      path = Pathname.new("~/.config/nvim_conf").expand_path
      FileUtils.remove_dir(path) if File.directory?(path)
    end
  end

  it "creates folder with init.lua" do
    expect(
      File.exist?(
        path
      )
    ).to eq(true)

    expect(
      File.exist?(
        path + "init.lua"
      )
    ).to eq(true)

    expected_result = <<~RESULT
      vim.o.tabstop = true


      vim.api.nvim_set_keymap('n', '<CTRL-c>', ':Git Blame')


      local fn = vim.fn
      local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
      if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
      end

      return require('packer').startup(function()
        {use 'glacambre/firenvim', opt = true, run = 'cd folder'}
        {use 'glepnir/galaxyline.nvim', opt = true, branch = 'main'}

        if packer_bootstrap then
          require('packer').sync()
        end

      end)


      vim.api.nvim_set_keymap('n', '<CTRL-c>', ':Git Blame')
      vim.api.nvim_set_keymap('n', '<CTRL-c>', ':Git Blame')


      vim.o.nvim-linter = true
      vim.o.tester = true
    RESULT

    expect(File.read(path + "init.lua")).to eq(expected_result)

    expected_result = <<~RESULT
      # Configuration Documentation Vim - NvimConf
    
      ## Settings


      ### Set
      - tabstop => true
      - nvim-linter => true
      - tester => true


      ## Mappings


      ### nmap
      - <CTRL-c> => :Git Blame
      - <CTRL-c> => :Git Blame
      - <CTRL-c> => :Git Blame


      ## Plugins

      ### Packer
      
      <details>
        <summary>
          glacambre/firenvim
        </summary>

        glacambre/firenvim
      </details>

      <details>
        <summary>
          glepnir/galaxyline.nvim
        </summary>

        glepnir/galaxyline.nvim
      </details>



    RESULT

    expect(File.read(path + "Init.md")).to eq(expected_result)
  end
end
