module NvimConf
  module Writers
    module Code
      class MappingsWriter
        def initialize(manager, io, configuration)
          @manager = manager
          @io = io
          @configuration = configuration
        end

        def write
          @manager.mappings.each do |mapping|
            @io.write(
              [
                generator_class.new(mapping).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:mappings, @configuration[:format])
        end
      end
    end
  end
end
