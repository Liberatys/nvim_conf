require "dry-initializer"

module NvimConf
  module Models
    class Group
      DEFAULT_NAME = "No Group"

      extend Dry::Initializer

      param :name
      param :label, optional: true
      param :children, default: -> { [] }

      def section_title
        label || name
      end

      def render_title?
        name != DEFAULT_NAME
      end
    end
  end
end
