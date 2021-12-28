module NvimConf
  module Utils
    class Escaper
      class << self
        def escape_string(value)
          return value unless value.is_a?(String)
        end
      end
    end
  end
end
