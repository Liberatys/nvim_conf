require "nvim_conf/models/global"

module NvimConf
  module Managers
    class Globals < Manager
      def set(name, value = true)
        store_global(
          name,
          value
        )
      end

      class << self
        def section_name
          "Globals"
        end
      end

      def unset(name)
        store_global(
          name,
          false
        )
      end

      private

      def store_global(name, value)
        new_child(
          Models::Global.new(
            name,
            value
          )
        )
      end
    end
  end
end
