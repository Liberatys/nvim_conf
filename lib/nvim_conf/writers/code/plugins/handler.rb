require_relative "./configuration"

module NvimConf
  module Writers
    module Code
      module Plugins
        class Handler
          def initialize(manager, io, _params)
            @manager = manager
            @io = io
            @configuration = Configuration::PLUGIN_CONFIGURATION[manager.name.to_sym]
          end

          def write
            @configuration[:writer].new(
              @manager,
              @io,
              @configuration
            ).write
          end
        end
      end
    end
  end
end
