require "nvim_conf/generators/code/globals/lua"

module NvimConf
  module Writers
    module Code
      class GlobalsWriter < BaseWriter
        GLOBAL_GENERATOR_MAPPING = {
          lua: Generators::Globals::Code::Lua
        }

        def generator_class
          GLOBAL_GENERATOR_MAPPING[@configuration[:format]]
        end
      end
    end
  end
end
