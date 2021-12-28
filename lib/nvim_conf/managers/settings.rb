require "nvim_conf/models/setting"

module NvimConf
  module Managers
    class Settings < Manager
      attr_reader :title

      def initialize(title)
        super()
        @title = title
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
        new_child(
          Models::Setting.new(operation, key, value, scope)
        )
      end
    end
  end
end
