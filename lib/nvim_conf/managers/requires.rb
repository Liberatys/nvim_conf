require "nvim_conf/models/require"

# TODO: Refactor error messages
module NvimConf
  module Managers
    class Requires
      attr_reader :requires

      def initialize
        @requires = []
      end

      class << self
        def section_name
          "Requires"
        end
      end

      def setup(file)
        store_require(file)
      end

      private

      def store?
        @requires.any?
      end

      def store_require(file)
        @requires << Models::Require.new(file)
      end
    end
  end
end
