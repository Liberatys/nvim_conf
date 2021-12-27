module NvimConf
  module Generators
    module Requires
      module Code
        class Lua
          def initialize(require)
            @require = require
          end

          def generate
            build_statement
          end

          private

          def build_statement
            "require '#{@require.file}'.setup{}"
          end
        end
      end
    end
  end
end
