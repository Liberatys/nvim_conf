module NvimConf
  module Writers
    module Documentation
      class Plugins
        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.empty?

          @io.write(
            Utils::MarkdownFormatter.format_title(
              "Plugins",
              level: 2
            )
          )

          write_plugins
        end

        private

        def write_plugins
          @managers.each do |manager|
            @io.write(
              Utils::MarkdownFormatter.format_title(
                manager.name.capitalize,
                level: 3
              )
            )

            manager.plugins.each do |plugin|
              @io.write(
                Utils::MarkdownFormatter.collapisible(
                  plugin.name,
                  plugin.name
                )
              )
              @io.write("\n")
            end

            write_separator
          end
        end

        def write_separator
          @io.write(
            Utils::MarkdownFormatter.separator
          )
        end
      end
    end
  end
end
