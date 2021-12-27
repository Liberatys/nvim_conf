require "nvim_conf/generators/code/commands/lua"

module NvimConf
  module Writers
    module Code
      class CommandsWriter
        COMMANDS_GENERATOR_MAPPING = {
          lua: Generators::Commands::Code::Lua
        }

        def initialize(manager, io, format: :lua, commented: false)
          @manager = manager
          @io = io
          @format = format
        end

        def write
          @manager.commands.each do |command|
            @io.write(
              [
                generator_class.new(command).generate,
                "\n"
              ].join
            )
          end
        end

        private

        def generator_class
          COMMANDS_GENERATOR_MAPPING[@format]
        end
      end
    end
  end
end
