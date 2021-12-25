RSpec.describe NvimConf::Writers::Documentation::Orchestrator do
  describe "#aggregate_writes" do
    before do
      NvimConf::Core.define do
        configuration do
          output_folder "$HOME/.config"
          code_output :lua
          documented true
          commented
        end

        settings do
          set :tabstop, 4
          set :tabstop
          unset :tabstop
        end

        mappings do
          map "<CTRL-c>", ":MarkdownPreview<CR>"
          nmap "<CTRL-c>", ":MarkdownPreview<CR>"
          imap "<CTRL-c>", ":MarkdownPreview<CR>"
        end
      end
    end

    it "writes the settings code to the IO device" do
      io_device = StringIO.new
      described_class.new(
        NvimConf.managers,
        io_device,
        {format: :vim, commented: false, documented: true}
      ).aggregate_writes

      expected_result = <<~RESULT
        # Configuration Documentation Vim - NvimConf
      
        ## Settings
      

        ### Set
        - tabstop => 4
        - tabstop => true

        
        ### Unset
        - tabstop => false
      

        ## Mappings
     
      
        ### map
        - <CTRL-c> => :MarkdownPreview<CR>


        ### nmap
        - <CTRL-c> => :MarkdownPreview<CR>
      

        ### imap
        - <CTRL-c> => :MarkdownPreview<CR>


      RESULT

      expect(
        io_device.string
      ).to eq(
        expected_result
      )
    end
  end
end
