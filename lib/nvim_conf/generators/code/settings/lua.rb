module NvimConf
  module Generators
    module Settings
      module Code
        class Lua
          VIM_PREFIX = :vim

          SETTING_NAMESPACES = {
            global: "o",
            buffer: "bo"
          }

          def initialize(setting)
            @setting = setting
          end

          def generate
            [
              call_signature,
              escaped_value
            ].join(operator)
          end

          private

          def operator
            %i[set unset].include?(@setting.operation) ? " = " : " += "
          end

          def call_signature
            [
              VIM_PREFIX,
              SETTING_NAMESPACES[@setting.scope] || SETTING_NAMESPACES[:global],
              @setting.key
            ].join(".")
          end

          def escaped_value
            return fallback_to_truthy_on_nil(@setting.value) unless @setting.value.is_a?(String)

            [
              '"',
              @setting.value,
              '"'
            ].join
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
