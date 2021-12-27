module NvimConf
  module Generators
    module Commands
      module Code
        class Lua
          def initialize(command)
            @command = command
          end

          def generate
            send("#{@command.vim_exec ? "vim" : "lua"}_exec")
          end

          private

          def lua_exec
            @command.body
          end

          def vim_exec
            <<~FORMAT
              vim.cmd([[
              #{align_line_start(@command.body)}
              ]])
            FORMAT
          end

          def align_line_start(body)
            body.split("\n").map do |line|
              "  #{line}"
            end.join("\n")
          end
        end
      end
    end
  end
end
