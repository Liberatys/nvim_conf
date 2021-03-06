require_relative "./packer"
require_relative "./paq"

module NvimConf
  module Writers
    module Code
      module Plugins
        class Configuration
          PLUGIN_CONFIGURATION = {
            packer: {
              generator: NvimConf::Generators::Plugins::Code::Packer,
              writer: NvimConf::Writers::Code::Plugins::Packer,
              indent: 2
            },
            paq: {
              generator: NvimConf::Generators::Plugins::Code::Paq,
              writer: NvimConf::Writers::Code::Plugins::Paq,
              indent: 2
            }
          }
        end
      end
    end
  end
end
