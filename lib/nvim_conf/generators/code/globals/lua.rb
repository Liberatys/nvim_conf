module NvimConf
  module Generators
    module Globals
      module Code
        class Lua
          def initialize(global)
            @global = global
          end

          def generate
            [
              "vim.g.#{@global.name}",
              format_value(@global.value)
            ].join(" = ")
          end

          private

          def format_value(value)
            case value
            when String
              [
                '"',
                value,
                '"'
              ].join
            when Array
              [
                "{",
                value.map { |inner_value| format_value(inner_value) }.join(", "),
                "}"
              ].join
            else
              fallback_to_truthy_on_nil(value)
            end
          end

          def fallback_to_truthy_on_nil(value)
            return value unless value.nil?

            @setting.operation == :set
          end
        end
      end
    end
  end
end
