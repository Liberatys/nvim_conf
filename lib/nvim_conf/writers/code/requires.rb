module NvimConf
  module Writers
    module Code
      class RequiresWriter < BaseWriter
        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:requires, @configuration[:format])
        end
      end
    end
  end
end
