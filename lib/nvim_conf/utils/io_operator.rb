require "forwardable"

module NvimConf
  module Utils
    class IoOperator
      extend Forwardable

      def_delegators :@io, :write, :string

      def initialize(io)
        @io = io
      end

      def write_separator
        @io.write(
          Utils::MarkdownFormatter.separator
        )
      end

      def write_group(manager, group)
        return unless group.render_title?

        @io.write(
          NvimConf::Commenter.comment_block(
            nil,
            "#{manager.class.section_name} - #{group.section_title}",
            spacer: true
          )
        )
      end
    end
  end
end
