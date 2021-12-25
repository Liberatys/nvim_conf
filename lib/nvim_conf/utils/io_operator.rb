require "forwardable"

module NvimConf
  module Utils
    class IoOperator
      extend Forwardable

      def_delegators :@io, :write

      def initialize(io)
        @io = io
      end

      def write_separator
        @io.write(
          Utils::MarkdownFormatter.separator
        )
      end
    end
  end
end
