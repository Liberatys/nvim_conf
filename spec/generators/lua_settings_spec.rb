RSpec.describe NvimConf::Generators::Settings::Code::Lua do
  describe ".generate" do
    let(:setting) do
      NvimConf::Settings::Setting.new(
        :set,
        :tabstop,
        4
      )
    end

    it "generates code to set setting" do
      expect(
        described_class.new(setting).generate
      )
        .to eq("vim.o.#{setting.key} = #{setting.value}")
    end

    context "when setting requires quotes surrounding value" do
      let(:setting) do
        NvimConf::Settings::Setting.new(
          :set,
          :tabstop,
          "4"
        )
      end

      it "generates code to set setting and persists the given format" do
        expect(
          described_class.new(setting).generate
        ).to eq("vim.o.#{setting.key} = \"#{setting.value}\"")
      end
    end
  end
end
