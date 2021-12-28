module NvimConf
  module Writers
    module Code
      class SettingsWriter < BaseWriter
        def generator_class
          NvimConf::CODE_WRITER_CONFIGURATION.dig(:settings, @configuration[:format])
        end
      end
    end
  end
end
