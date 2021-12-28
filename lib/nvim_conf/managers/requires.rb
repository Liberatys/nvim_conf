require "nvim_conf/models/require"

module NvimConf
  module Managers
    class Requires < Manager
      attr_reader :requires

      class << self
        def section_name
          "Requires"
        end
      end

      def setup(file)
        store_require(file)
      end

      private

      def store_require(file)
        new_child(
          Models::Require.new(file)
        )
      end
    end
  end
end
