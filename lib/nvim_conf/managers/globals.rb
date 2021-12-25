require "nvim_conf/models/global"

module NvimConf
  module Managers
    class Globals
      def initialize
        @globals = []
      end

      def set(name, value = true)
        store_global(
          name,
          value
        )
      end

      def store?
        @globals.any?
      end

      def unset(name)
        store_global(
          name,
          false
        )
      end

      private

      def store_global(name, value)
        @globals << Models::Global.new(
          name,
          value
        )
      end
    end
  end
end
