require "dry-initializer"

module NvimConf
  module Settings
    class Setting
      extend Dry::Initializer

      param :operation
      param :key
      param :value, optional: true
      param :scope, default: -> { :global }
    end
  end
end
