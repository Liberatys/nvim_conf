module NvimConf
  module Writers
    module Documentation
      class Globals
        def initialize(managers, io)
          @managers = managers
          @io = Utils::IoOperator.new(io)
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
                global.value
              ].join(" => ") + "\n"
            )
          end
        end
      end
    end
  end
end
