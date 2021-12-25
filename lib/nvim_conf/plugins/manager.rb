require "nvim_conf/plugins/plugin"

module NvimConf
  module Plugins
    class Manager < NvimConf::Manager
      attr_reader :plugins, :name, :bootstraped

      def initialize(name, bootstraped: false)
        @name = name
        @bootstraped = bootstraped
        @plugins = []
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
        Plugin.new(
          name,
          **params
        )
      end
    end
  end
end
