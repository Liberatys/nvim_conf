module NvimConf
  module Writers
    module Documentation
      class Globals
        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.nil? || @managers.empty?

          @io.write(
            Utils::MarkdownFormatter.format_title(
              "Globals",
              level: 2
            )
          )

          write_globals
        end

        private

        def write_globals
          @managers.map(&:globals).flatten.each do |global|
            @io.write(
              [
                "- #{global.name}",
                transformed_value(global.value)
              ].join(" => ") + "\n"
            )
          end
        end

        def transformed_value(value)
          return value.join(", ") if value.is_a?(Array)
          return value unless value.nil?

          value
        end
      end
    end
  end
end
