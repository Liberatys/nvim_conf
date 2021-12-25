module NvimConf
  module Writers
    module Documentation
      class Mappings
        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.empty?

          @io.write(
            Utils::MarkdownFormatter.format_title(
              "Mappings",
              level: 2
            )
          )

          write_mappings(all_mappings.group_by(&:operator))
        end

        private

        def write_mappings(grouped_mappings)
          grouped_mappings.each do |operator, mappings|
            write_separator

            @io.write(
              Utils::MarkdownFormatter.format_title(
                operator,
                level: 3
              )
            )

            mappings.each do |mapping|
              @io.write(
                [
                  "- #{mapping.binding}",
                  mapping.action
                ].join(" => ") + "\n"
              )
            end
          end
        end

        def all_mappings
          @managers.map(&:mappings).flatten
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
