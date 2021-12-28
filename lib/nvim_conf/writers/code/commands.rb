require "nvim_conf/generators/code/commands/lua"

module NvimConf
  module Writers
    module Code
      class CommandsWriter
        COMMANDS_GENERATOR_MAPPING = {
          lua: Generators::Commands::Code::Lua
        }

        def initialize(manager, io, configuration)
          @manager = manager
          @io = io
          @configuration = configuration
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
          COMMANDS_GENERATOR_MAPPING[@configuration[:format]]
        end
      end
    end
  end
end
