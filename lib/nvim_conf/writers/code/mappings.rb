require "nvim_conf/generators/code/mappings/lua"
require "nvim_conf/generators/code/mappings/vim"

module NvimConf
  module Writers
    module Code
      class MappingsWriter
        MAPPING_GENERATOR_MAPPING = {
          lua: Generators::Mappings::Code::Lua,
          vim: Generators::Mappings::Code::Vim
        }

        def initialize(manager, io, configuration)
          @manager = manager
          @io = io
          @configuration = configuration
        end

        def write
          @manager.mappings.each do |mapping|
            @io.write(
              [
                generator_class.new(mapping).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          MAPPING_GENERATOR_MAPPING[@configuration[:format]]
        end
      end
    end
  end
end
