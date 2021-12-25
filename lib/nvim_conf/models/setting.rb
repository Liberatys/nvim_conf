require "dry-initializer"

module NvimConf
  module Models
    class Setting
      extend Dry::Initializer

      param :operation
      param :key
      param :value, optional: true
      param :scope, default: -> { :global }
    end
  end
end
