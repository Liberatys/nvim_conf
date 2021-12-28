require "nvim_conf/models/command"

module NvimConf
  module Managers
    class Commands < Manager
      class << self
        def section_name
          "Commands"
        end
      end

      def command(name, description: "", body: "", vim_exec: false)
        store_command(name, description, body, vim_exec)
      end

      alias_method :new, :command
      alias_method :c, :command

      private

      def store_command(name, description, body, vim_exec)
        new_child(
          Models::Command.new(
            name, description, body, vim_exec: vim_exec
          )
        )
      end
    end
  end
end
