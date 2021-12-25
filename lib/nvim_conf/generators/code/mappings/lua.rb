module NvimConf
  module Generators
    module Mappings
      module Code
        class Lua
          MODE_MAPPING = {
            "map" => "",
            "nmap" => "n",
            "vmap" => "v",
            "smap" => "s",
            "xmap" => "x",
            "omap" => "o",
            "map!" => "!",
            "imap" => "i",
            "lmap" => "l",
            "cmap" => "c",
            "tmap" => "t"
          }

          BASE_METHOD = "vim.api.nvim_set_keymap"

          def initialize(mapping)
            @mapping = mapping
          end

          def generate
            [
              BASE_METHOD,
              "(",
              argument_list,
              ")"
            ].join
          end

          private

          def argument_list
            [
              MODE_MAPPING[@mapping.operator.to_s],
              @mapping.binding,
              @mapping.action
            ].map do |value|
              [
                "\'",
                value,
                "\'"
              ].join
            end.join(", ")
          end
        end
      end
    end
  end
end
