require "nvim_conf/generators/code/settings/lua"
require "nvim_conf/generators/code/settings/vim"

module NvimConf
  module Writers
    module Code
      class SettingsWriter
        SETTING_GENERATOR_MAPPING = {
          lua: Generators::Settings::Code::Lua,
          vim: Generators::Settings::Code::Vim
        }

        def initialize(manager, io, format:, commented:)
          @manager = manager
          @io = io
          @format = format
        end

        def write
          @manager.settings.each do |setting|
            @io.write(
              [
                generator_class.new(setting).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          SETTING_GENERATOR_MAPPING[@format]
        end
      end
    end
  end
end
