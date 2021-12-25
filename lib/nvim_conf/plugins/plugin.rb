require "dry-initializer"

module NvimConf
  module Plugins
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
    end
  end
end
