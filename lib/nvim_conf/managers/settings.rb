require "nvim_conf/models/setting"

module NvimConf
  module Managers
    class Settings
      attr_reader :settings, :title

      def initialize(title)
        @title = title
        @settings = []
      end

      def store?
        @settings.any?
      end

      class << self
        def section_name
          "Settings"
        end
      end

      def set(key, value = nil, **params)
        store_setting(
          :set,
          key: key,
          value: value,
          **params
        )
      end

      def unset(key)
        store_setting(
          :unset,
          key: key
        )
      end

      def add(key, value, **params)
        store_setting(
          :add,
          key: key,
          value: value,
          **params
        )
      end

      private

      def store_setting(operation, key:, value: nil, scope: :global)
        @settings << build_setting(operation, key, value, scope)
      end

      def build_setting(operation, key, value, scope)
        Models::Setting.new(operation, key, value, scope)
      end
    end
  end
end
