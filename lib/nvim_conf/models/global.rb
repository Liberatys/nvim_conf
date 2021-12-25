require "dry-initializer"

module NvimConf
  module Models
    class Global
      extend Dry::Initializer

      param :name
      param :value, default: -> { true }
    end
  end
end
