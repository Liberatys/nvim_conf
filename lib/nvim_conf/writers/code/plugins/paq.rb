module NvimConf
  module Writers
    module Code
      module Plugins
        class Paq
          BLOCK_START = <<~START
            require "paq" {
          START

          BLOCK_END = <<~END
            }
          END

          def initialize(manager, io, configuration)
            @manager = manager
            @io = io
            @configuration = configuration
            @plugins = manager.all_children
          end

          def write
            @io.write(
              BLOCK_START
            )

            @plugins.each do |plugin|
              @io.write(
                "#{plugin_indent(@configuration[:generator].new(plugin).generate)}\n"
              )
            end

            @io.write(
              BLOCK_END
            )
          end

          private

          def plugin_indent(content)
            [
              " " * @configuration[:indent],
              content
            ].join
          end
        end
      end
    end
  end
end
