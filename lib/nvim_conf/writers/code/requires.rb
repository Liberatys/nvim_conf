require "nvim_conf/generators/code/requires/lua"

module NvimConf
  module Writers
    module Code
      class RequiresWriter
        REQUIRE_GENERATOR_MAPPING = {
          lua: Generators::Requires::Code::Lua
        }

        def initialize(manager, io, format: :lua, commented: false)
          @manager = manager
          @io = io
          @format = format
        end

        def write
          @manager.requires.each do |require|
            @io.write(
              [
                generator_class.new(require).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          REQUIRE_GENERATOR_MAPPING[@format]
        end
      end
    end
  end
end
