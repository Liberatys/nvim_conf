require "dry-initializer"

module NvimConf
  module Models
    class Command
      extend Dry::Initializer

      param :name
      param :description
      param :body

      option :vim_exec, default: -> { false }
    end
  end
end
