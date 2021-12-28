module NvimConf
  module Utils
    class Escaper
      class << self
        SYMBOLD_CONFIGURATION = {
          array: {
            start: "{",
            end: "}",
            separator: ", "
          }
        }
        def escape_value(value)
          return value if value.nil?

          case value

          when String
            escape_string(value)
          when Array
            [
              SYMBOLD_CONFIGURATION.dig(:array, :start),
              value.map do |inner_value|
                escape_value(inner_value)
              end.join(SYMBOLD_CONFIGURATION.dig(:array, :separator)),
              SYMBOLD_CONFIGURATION.dig(:array, :end)
            ].join
          end
        end

        def escape_string(value)
          return value unless value.is_a?(String)

          string_wrapper = value.include?("\'") ? "\"" : "\'"

          [
            string_wrapper,
            value,
            string_wrapper
          ].join
        end
      end
    end
  end
end
