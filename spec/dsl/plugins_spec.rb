RSpec.describe "DSL => Plugins" do
  describe "plugins" do
    context "when no plugins are registered with the manager" do
      it "does not store manager on NvimConf" do
        NvimConf::Core.define do
          plugins :packer do
          end
        end
        expect(NvimConf.managers.length).to eq(0)
      end
    end

    context "when more than one plugin is registered with the manager" do
      it "stores all plugins defined in the dsl" do
        NvimConf::Core.define do
          plugins :packer do
            plug "nvim-linter"
            plug "tester"
          end
        end
        expect(NvimConf.managers.length).to eq(1)
        expect(NvimConf.managers.first.plugins.length).to eq(2)
        expect(NvimConf.managers.first.plugins.map(&:name)).to eq(%w[nvim-linter tester])
      end
    end

    context "when plugin has additional arguments" do
      it "stores given attributes if plugin is expecting them" do
        NvimConf::Core.define do
          plugins :packer do
            plug "nvim-linter", loader: :git, provider: :github
            plug "tester", run: "./install.sh"
          end
        end
        expect(NvimConf.managers.length).to eq(1)
        expect(NvimConf.managers.first.plugins.length).to eq(2)
        expect(NvimConf.managers.first.plugins.map(&:name)).to eq(%w[nvim-linter tester])
      end
    end
  end
end
