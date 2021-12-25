require "nvim_conf/mappings/mapping"
# TODO: Refactor error messages
module NvimConf
  module Mappings
    class Manager < NvimConf::Manager
      AVAILABLE_METHODS = %w[map map! nmap vmap imap cmap smap xmap omap lmap]
      attr_reader :mappings

      def initialize(namespace)
        @mappings = []
        @namespace = namespace&.to_s

        validate!
      end

      def validate!
        return if @namespace.nil? || @namespace.empty?

        raise "Invalid namespace given for <mappings>: #{@namespace}" unless AVAILABLE_METHODS.include?(@namespace)
      end

      def store?
        @mappings.any?
      end

      AVAILABLE_METHODS.each do |operator|
        define_method(operator) do |binding, action|
          store_mapping(
            operator, binding, action
          )
        end
      end

      def new(binding, action)
        raise "No namespace was given for <mappings>" unless @namespace
        raise "No namespace was given for <mappings>" if @namespace.empty?

        store_mapping(
          @namespace, binding, action
        )
      end

      alias_method :m, :new

      private

      def store_mapping(operator, binding, action)
        @mappings << build_mapping(
          operator, binding, action
        )
      end

      def build_mapping(operator, binding, action)
        Mapping.new(operator, binding, action)
      end
    end
  end
end
