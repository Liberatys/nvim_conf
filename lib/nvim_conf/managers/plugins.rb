require "nvim_conf/models/plugin"

module NvimConf
  module Managers
    class Plugins
      attr_reader :plugins, :name, :title, :bootstraped

      def initialize(name, title, bootstraped: false)
        @name = name
        @title = title
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
