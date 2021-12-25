require "nvim_conf/models/plugin"

module NvimConf
  module Plugins
    class Manager
      attr_reader :plugins, :name, :bootstraped

      def initialize(name, bootstraped: false)
        @name = name
        @bootstraped = bootstraped
        @plugins = []
      end

      class << self
        def section_name
          "Plugins"
        end
      end

      def store?
        @plugins.any?
      end

      def plug(name, **params)
        store_plugin(
          name,
          params
        )
      end

      private

      def store_plugin(name, params)
        @plugins << build_plugin(
          name, params
        )
      end

      def build_plugin(name, params)
        Models::Plugin.new(
          name,
          **params
        )
      end
    end
  end
end
