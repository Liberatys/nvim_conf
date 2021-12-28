module NvimConf
  module Writers
    module Code
      class MappingsWriter < BaseWriter
        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:mappings, @configuration[:format])
        end
      end
    end
  end
end
