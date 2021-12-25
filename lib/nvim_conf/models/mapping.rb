require "dry-initializer"

module NvimConf
  module Models
    class Mapping
      extend Dry::Initializer

      param :operator
      param :binding
      param :action
    end
  end
end
