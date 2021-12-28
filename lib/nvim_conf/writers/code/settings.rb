require "nvim_conf/generators/code/settings/lua"
require "nvim_conf/generators/code/settings/vim"

module NvimConf
  module Writers
    module Code
      class SettingsWriter < BaseWriter
        SETTING_GENERATOR_MAPPING = {
          lua: Generators::Settings::Code::Lua,
          vim: Generators::Settings::Code::Vim
        }

        def generator_class
          SETTING_GENERATOR_MAPPING[@configuration[:format]]
        end
      end
    end
  end
end
