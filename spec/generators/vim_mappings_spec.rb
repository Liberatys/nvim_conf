RSpec.describe NvimConf::Generators::Mappings::Code::Vim do
  describe "#generate" do
    %i[
      map
      nmap
      imap
    ].each do |map_method|
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
          ).to eq("#{map_method} #{mapping.binding} #{mapping.action}")
        end
      end
    end
  end
end
