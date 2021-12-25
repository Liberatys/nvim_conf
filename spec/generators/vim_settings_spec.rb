RSpec.describe NvimConf::Generators::Settings::Code::Vim do
  let(:model_class) { NvimConf::Models::Setting }
  describe ".generate" do
    context "when setting has value" do
      let(:setting) do
        model_class.new(
          :set,
          :tabstop,
          4
        )
      end

      it "generates set command" do
        expect(
          described_class.new(setting).generate
        ).to eq("set #{setting.key} = #{setting.value}")
      end
    end

    context "when setting has no value" do
      let(:setting) do
        model_class.new(
          :set,
          :tabstop
        )
      end

      it "generates set command" do
        expect(
          described_class.new(setting).generate
        ).to eq("set #{setting.key}")
      end
    end

    context "when unset is used" do
      let(:setting) do
        model_class.new(
          :unset,
          :tabstop
        )
      end

      it "generates set command" do
        expect(
          described_class.new(setting).generate
        ).to eq("set #{setting.key}!")
      end
    end
  end
end
