module NvimConf
  module Generators
    module Settings
      module Code
        class Lua
          VIM_PREFIX = :vim

          SETTING_NAMESPACES = {
            global: "o",
            buffer: "bo",
            opt: "opt"
          }

          def initialize(setting)
            @setting = setting
          end

          def generate
            if %i[set unset].include?(@setting.operation)
              generate_set
            else
              generate_addition
            end
          end

          private

          def generate_addition
            "#{call_signature}:append(#{format_value(@setting.value)})"
          end

          def generate_set
            [
              call_signature,
              format_value(@setting.value)
            ].join(" = ")
          end

          def call_signature
            [
              VIM_PREFIX,
              SETTING_NAMESPACES[@setting.scope] || SETTING_NAMESPACES[:global],
              @setting.key
            ].join(".")
          end

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
