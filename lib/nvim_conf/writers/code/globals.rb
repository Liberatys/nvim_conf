require "nvim_conf/generators/code/globals/lua"

module NvimConf
  module Writers
    module Code
      class GlobalsWriter
        GLOBAL_GENERATOR_MAPPING = {
          lua: Generators::Globals::Code::Lua
        }

        def initialize(manager, io, format: :lua, commented: false)
          @manager = manager
          @io = io
          @format = format
        end

        def write
          @manager.globals.each do |global|
            @io.write(
              [
                generator_class.new(global).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          GLOBAL_GENERATOR_MAPPING[@format]
        end
      end
    end
  end
end
