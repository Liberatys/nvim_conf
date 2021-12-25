RSpec.describe NvimConf::Generators::Mappings::Code::Lua do
  describe "#generate" do
    {
      map: "",
      nmap: "n",
      imap: "i"
    }.each do |map_method, shorthand|
      context "when method is #{map_method}" do
        let(:mapping) do
          NvimConf::Mappings::Mapping.new(
            map_method,
            "<Ctrl-g>",
            ":Git Blame"
          )
        end

        it "generates mapping for given method" do
          expect(
            described_class.new(
              mapping
            ).generate
          ).to eq("vim.api.nvim_set_keymap('#{shorthand}', '<Ctrl-g>', ':Git Blame')")
        end
      end
    end
  end
end
