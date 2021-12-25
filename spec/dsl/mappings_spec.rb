RSpec.describe "DSL => Mappings" do
  describe "mappings" do
    context "when no mappings are defined" do
      it "does not store manager on NvimConf" do
        NvimConf::Core.define do
          mappings do
          end
        end
        expect(NvimConf.managers.length).to eq(0)
      end
    end

    context "when more than one mapping is defined" do
      it "does store manager on NvimConf" do
        NvimConf::Core.define do
          mappings do
            nmap "<CTRL-c>", ":Git Blame"
          end
        end
        expect(NvimConf.managers.length).to eq(1)
      end
    end

    context "when more than one mapping is defined and namespace is used" do
      it "does store manager on NvimConf" do
        NvimConf::Core.define do
          mappings(:nmap) do
            m "<CTRL-c>", ":Git Blame"
            m "<CTRL-c>", ":Git Blame"
          end

          mappings(:vmap) do
            new "<CTRL-c>", ":Git Blame"
            new "<CTRL-c>", ":Git Blame"
          end
        end
        expect(NvimConf.managers.length).to eq(2)
        expect(NvimConf.managers.first.mappings.map(&:operator)).to eq(%w[nmap nmap])
        expect(NvimConf.managers.last.mappings.map(&:operator)).to eq(%w[vmap vmap])
      end
    end
  end
end
