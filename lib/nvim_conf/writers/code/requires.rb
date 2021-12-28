require "nvim_conf/generators/code/requires/lua"

module NvimConf
  module Writers
    module Code
      class RequiresWriter < BaseWriter
        REQUIRE_GENERATOR_MAPPING = {
          lua: Generators::Requires::Code::Lua
        }

        def generator_class
          REQUIRE_GENERATOR_MAPPING[@configuration[:format]]
        end
      end
    end
  end
end
