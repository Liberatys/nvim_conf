module NvimConf
  module Generators
    module Globals
      class Lua
        def initialize(global)
          @global = global
        end

        def generate
          [
            "vim.g.#{@global.name}",
            escaped_value
          ].join(' = ')
        end

        private

        def escaped_value
          return @global.value unless @global.value.is_a?(String)

          [
            '"',
            @global.value,
            '"'
          ].join
        end
      end
    end
  end
end
