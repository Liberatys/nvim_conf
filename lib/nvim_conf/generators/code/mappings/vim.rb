module NvimConf
  module Generators
    module Mappings
      module Code
        class Vim
          def initialize(mapping)
            @mapping = mapping
          end

          def generate
            [
              vim_method,
              @mapping.binding,
              @mapping.action
            ].join(" ")
          end

          private

          def vim_method
            @mapping.operator.to_s
          end
        end
      end
    end
  end
end
