RSpec.describe NvimConf::ConfigurationBuilder do
  describe "#build_configuration" do
    context "when only one configuration scope is given" do
      before do
        NvimConf::Core.define do
          configuration do
            output_folder "$HOME/.config"
            code_output :lua
            documented true
            commented
          end
        end
      end

      let(:builder) { described_class.new(NvimConf.managers) }

      it "builds configuration based on dsl" do
        expect(builder.build_configuration).to eq(
          {
            output_folder: "$HOME/.config",
            code_output: "lua",
            mono_file: true,
            write: false,
            documented: true,
            commented: true,
            schema: :nvim,
            format: :lua
          }
        )
      end
    end

    context "when multiple configuration scopes are given" do
      before do
        NvimConf::Core.define do
          configuration do
            output_folder "$HOME/.config"
            code_output :lua
            documented true
            commented
          end

          configuration do
            output_folder "$HOME/.config/neovim"
            code_output :vim
            documented false
            commented false
          end

          configuration do
            output_folder "$HOME/.config/neovim"
            mono_file false
          end
        end
      end

      let(:builder) { described_class.new(NvimConf.managers) }

      it "builds configuration as a merge of multiple scopes and preferes last added option" do
        expect(builder.build_configuration).to eq(
          {
            output_folder: "$HOME/.config/neovim",
            code_output: "vim",
            mono_file: false,
            write: false,
            format: :lua,
            schema: :nvim,
            documented: false,
            commented: false
          }
        )
      end
    end
  end
end
