RSpec.describe NvimConf::Generators::Plugins::Code::Packer do
  let(:model_class) { NvimConf::Models::Plugin }
  subject(:call) do
    NvimConf::Generators::Plugins::Code::Packer.new(
      plugin
    ).generate
  end

  describe "#generate" do
    context "when no optional parameters are given" do
      let(:plugin) do
        model_class.new(
          "wbthomason/packer.nvim"
        )
      end

      it { is_expected.to eq("use 'wbthomason/packer.nvim'") }
    end

    context "when has opt argument" do
      let(:plugin) do
        model_class.new(
          "wbthomason/packer.nvim",
          opt: true
        )
      end

      it { is_expected.to eq("{use 'wbthomason/packer.nvim', opt = true}") }
    end

    context "when has run argument" do
      let(:plugin) do
        model_class.new(
          "wbthomason/packer.nvim",
          run: "cd app && yarn install"
        )
      end

      it { is_expected.to eq("{use 'wbthomason/packer.nvim', run = 'cd app && yarn install'}") }
    end

    context "when has run and opt argument" do
      let(:plugin) do
        model_class.new(
          "wbthomason/packer.nvim",
          run: "cd app && yarn install",
          opt: true
        )
      end

      it { is_expected.to eq("{use 'wbthomason/packer.nvim', opt = true, run = 'cd app && yarn install'}") }
    end
  end
end
