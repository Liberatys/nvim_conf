require "dry-initializer"

module NvimConf
  module CompilerConfigurations
    class CompilerConfiguration
      extend Dry::Initializer

      param :name
      param :value
    end
  end
end
