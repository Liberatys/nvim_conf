require 'nvim_conf/models/plugin'

module NvimConf
  module Managers
    class Plugins < Manager
      attr_reader :name, :title, :bootstraped

      def initialize(name, title, bootstraped: false)
        super()
        @name = name
        @title = title
        @bootstraped = bootstraped
      end

      class << self
        def section_name
          'Plugins'
        end
      end

      def plug(name, **params)
        store_plugin(
          name,
          params
        )
      end

      private

      def store_plugin(name, params)
        new_child(
          Models::Plugin.new(
            name,
            **params
          )
        )
      end
    end
  end
end
