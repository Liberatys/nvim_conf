require "dry-initializer"

module NvimConf
  module Models
    class Group
      extend Dry::Initializer

      param :name
      param :label, optional: true
      param :children, default: -> { [] }
    end
  end
end
