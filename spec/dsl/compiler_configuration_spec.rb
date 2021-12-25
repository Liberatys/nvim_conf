RSpec.describe "DSL => Compiler Configurations" do
  describe "compiler_configurations" do
    context "when no plugins are registered with the manager" do
      it "does not store manager on NvimConf" do
        NvimConf::Core.define do
          configuration do
          end
        end
        expect(NvimConf.managers.length).to eq(0)
      end
    end

    context "when more than one configuration is registered with the manager" do
      it "does store manager on NvimConf" do
        NvimConf::Core.define do
          configuration do
            output_folder "$HOME/.config"
            code_output :lua
            documented [:markdown]
            commented
          end
        end
        expect(NvimConf.managers.length).to eq(1)
        expect(NvimConf.managers.first.configurations.map(&:name)).to eq(%i[output_folder code_output documented
          commented])
      end
    end
  end
end
