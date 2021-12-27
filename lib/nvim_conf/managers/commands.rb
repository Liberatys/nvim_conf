require "nvim_conf/models/command"

module NvimConf
  module Managers
    class Commands
      attr_reader :commands

      def initialize
        @commands = []
      end

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
        @commands << Models::Command.new(
          name, description, body, vim_exec: vim_exec
        )
      end

      def store?
        @commands.any?
      end
    end
  end
end
