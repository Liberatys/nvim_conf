module NvimConf
  module Generators
    module Settings
      module Code
        class Vim
          SET_OPERATION = :set

          def initialize(setting)
            @setting = setting
          end

          def generate
            [
              call_identifier,
              escaped_value
            ].compact.join(" = ")
          end

          private

          def call_identifier
            [
              SET_OPERATION,
              negated_operator!
            ].join(" ")
          end

          def negated_operator!
            return @setting.key if @setting.operation == :set

            "#{@setting.key}!"
          end

          def escaped_value
            return @setting.value unless @setting.value.is_a?(String)

            [
              '"',
              @setting.value,
              '"'
            ].join
          end
        end
      end
    end
  end
end
