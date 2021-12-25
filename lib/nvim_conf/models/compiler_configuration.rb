require "dry-initializer"

module NvimConf
  module Models
    class CompilerConfiguration
      extend Dry::Initializer

      param :name
      param :value
    end
  end
end
