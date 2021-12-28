module NvimConf
  module Writers
    module Code
      class GlobalsWriter < BaseWriter
        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:globals, @configuration[:format])
        end
      end
    end
  end
end
