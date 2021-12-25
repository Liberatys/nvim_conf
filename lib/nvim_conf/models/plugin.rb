require "dry-initializer"

module NvimConf
  module Models
    class Plugin
      extend Dry::Initializer

      param :name
      option :loader, default: -> { :git }
      option :provider, default: -> { :github }
      option :branch, optional: true
      option :as, optional: true
      option :opt, optional: true
      option :file_types, optional: true
      option :cmd, optional: true
      option :run, optional: true

      def self.optional_arguments
        %i[as opt file_types branch run cmd]
      end
    end
  end
end
