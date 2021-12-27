require "dry-initializer"

module NvimConf
  module Models
    class Require
      extend Dry::Initializer

      param :file
    end
  end
end
