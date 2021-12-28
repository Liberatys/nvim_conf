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

          BASE_SET_METHOD = "vim.api.nvim_set_keymap"
          BASE_UNSET_METHOD = "vim.api.nvim_del_keymap"

          def initialize(mapping)
            @mapping = mapping
          end

          def generate
            if @mapping.remove
              generate_unset
            else
              generate_set
            end
          end

          private

          def generate_set
            [
              BASE_SET_METHOD,
              "(",
              argument_list,
              ")"
            ].join
          end

          def generate_unset
            [
              BASE_UNSET_METHOD,
              "(",
              [
                MODE_MAPPING[@mapping.operator.to_s],
                @mapping.binding
              ].map { |value| escape_value(value) }.join(", "),
              ")"
            ].join
          end

          def argument_list
            ([
              MODE_MAPPING[@mapping.operator.to_s],
              @mapping.binding,
              @mapping.action
            ].map { |value| escape_value(value) } + options).join(", ")
          end

          def escape_value(value)
            NvimConf::Utils::Escaper.escape_string(
              value
            )
          end

          def options
            ["{}"]
          end
        end
      end
    end
  end
end
