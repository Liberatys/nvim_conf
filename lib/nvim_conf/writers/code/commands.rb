module NvimConf
  module Writers
    module Code
      class CommandsWriter < BaseWriter
        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:commands, @configuration[:format])
        end
      end
    end
  end
end
