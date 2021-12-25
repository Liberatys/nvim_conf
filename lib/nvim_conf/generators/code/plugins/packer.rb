module NvimConf
  module Generators
    module Plugins
      module Code
        class Packer
          COMMAND_PREFIX = :use

          COMMAND_ALIAS = {
            file_types: :ft
          }

          def initialize(plugin)
            @plugin = plugin
          end

          def generate
            generated_call = [
              COMMAND_PREFIX,
              command_call
            ].join(" ")

            args? ? "{#{generated_call}}" : generated_call
          end

          private

          def command_call
            [
              plugin_name,
              *command_arguments
            ].compact.join(", ")
          end

          def plugin_name
            "'#{@plugin.name}'"
          end

          def command_arguments
            [
              :as,
              :opt,
              :file_types,
              :branch,
              :run,
              :cmd
            ].map do |argument|
              next if @plugin.send(argument).nil?

              [
                COMMAND_ALIAS[argument] || argument,
                escape_value(@plugin.send(argument))
              ].join(" = ")
            end.compact
          end

          def escape_value(value)
            return value unless value.is_a?(String)

            "'#{value}'"
          end

          def args?
            [
              @plugin.as,
              @plugin.opt,
              @plugin.branch,
              @plugin.file_types,
              @plugin.cmd,
              @plugin.run
            ].any? { |argument| !argument.nil? }
          end
        end
      end
    end
  end
end
