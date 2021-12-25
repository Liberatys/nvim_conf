module NvimConf
  module Writers
    module Documentation
      class Mappings
        MAIN_HEADER_PREFIX = "##"
        MAPPING_HEADER_PREFIX = "###"

        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.empty?

          @io.write(
            title(
              "Mappings",
              MAIN_HEADER_PREFIX
            )
          )

          write_mappings(all_mappings.group_by(&:operator))
        end

        private

        def write_mappings(grouped_mappings)
          grouped_mappings.each do |operator, mappings|
            write_separator

            @io.write(
              title(
                operator,
                MAPPING_HEADER_PREFIX
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
