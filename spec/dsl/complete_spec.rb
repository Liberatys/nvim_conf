RSpec.describe "DSL => Complete" do
  it "is able to build with multiple dsl rules" do
    NvimConf::Core.define do
      plugins :packer do
        plug "nvim-linter"
        plug "tester"
      end

      mappings do
        nmap "<CTRL-c>", ":Git Blame"
      end

      settings do
        set "nvim-linter"
        set "tester"
      end

      configuration do
        output_folder "$HOME/.config"
        code_output :lua
        documented [:markdown]
        commented
      end

      mappings(:nmap) do
        m "<CTRL-c>", ":Git Blame"
        m "<CTRL-c>", ":Git Blame"
      end

      globals do
        set :configuration
      end
    end
    managers = NvimConf.managers
    expect(managers.length).to eq(6)
    expect(managers[0].class).to eq(NvimConf::Managers::Plugins)
    expect(managers[1].class).to eq(NvimConf::Mappings::Manager)
    expect(managers[2].class).to eq(NvimConf::Settings::Manager)
    expect(managers[3].class).to eq(NvimConf::CompilerConfigurations::Manager)
    expect(managers[4].class).to eq(NvimConf::Mappings::Manager)
    expect(managers[5].class).to eq(NvimConf::Managers::Globals)
  end
end
