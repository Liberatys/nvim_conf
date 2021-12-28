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
          @manager.relevant_groups.each do |group|
            if group.render_title?
              @io.write(
                NvimConf::Commenter.comment_block(
                  nil,
                  "#{@manager.class.section_name} - #{group.section_title}",
                  spacer: true
                )
              )
            end
            group.children.each do |setting|
              @io.write(
                [
                  generator_class.new(setting).generate,
                  "\n"
                ].join
              )
            end
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
