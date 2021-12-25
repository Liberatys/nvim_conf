module NvimConf
  module Writers
    module Documentation
      class Plugins
        MAIN_HEADER_PREFIX = "##"
        MANAGER_HEADER_PREFIX = "###"

        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.empty?

          @io.write(
            title(
              "Plugins",
              MAIN_HEADER_PREFIX
            )
          )
          @io.write("\n")

          write_plugins
        end

        private

        def write_plugins
          @managers.each do |manager|
            @io.write(
              title(
                manager.name.capitalize,
                MANAGER_HEADER_PREFIX
              )
            )
            @io.write("\n")

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
            "\n\n"
          )
        end

        def title(text, prefix)
          "#{prefix} #{text}\n"
        end
      end
    end
  end
end
