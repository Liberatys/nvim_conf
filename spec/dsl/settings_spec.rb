RSpec.describe "DSL => Settings" do
  describe "settings" do
    context "when no settigns are registered with the manager" do
      it "does not store manager on NvimConf" do
        NvimConf::Core.define do
          settings do
          end
        end
        expect(NvimConf.managers.length).to eq(0)
      end
    end

    context "when more than one setting is registered with the manager" do
      it "stores all settings defined in the dsl" do
        NvimConf::Core.define do
          settings do
            set "nvim-linter"
            set "tester"
          end
        end
        expect(NvimConf.managers.length).to eq(1)
        expect(NvimConf.managers.first.settings.length).to eq(2)
      end

      it "stores each setting with its operation" do
        NvimConf::Core.define do
          settings do
            set "tabstop", 2
            set "softtab", true
            unset "tabstop"
          end
        end
        expect(NvimConf.managers.length).to eq(1)
        expect(NvimConf.managers.first.settings.length).to eq(3)
        expect(NvimConf.managers.first.settings.map(&:operation)).to eq(%i[set set unset])
      end
    end
  end
end
