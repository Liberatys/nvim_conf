require "nvim_conf/models/mapping"

# TODO: Refactor error messages
module NvimConf
  module Managers
    class Mappings < Manager
      AVAILABLE_METHODS = %w[map map! nmap vmap imap cmap smap xmap omap lmap tmap]
      attr_reader :mappings

      def initialize(namespace)
        @namespace = namespace&.to_s

        validate!
        super()
      end

      class << self
        def section_name
          "Mappings"
        end
      end

      def validate!
        return if @namespace.nil? || @namespace.empty?

        raise "Invalid namespace given for <mappings>: #{@namespace}" unless AVAILABLE_METHODS.include?(@namespace)
      end

      AVAILABLE_METHODS.each do |operator|
        define_method(operator) do |binding, action|
          store_mapping(
            operator, binding, action
          )
        end
      end

      AVAILABLE_METHODS.each do |operator|
        define_method("r#{operator}") do |binding|
          store_mapping(
            operator, binding, nil, remove: true
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

      def store_mapping(operator, binding, action, **params)
        new_child(
          Models::Mapping.new(operator, binding, action, **params)
        )
      end
    end
  end
end
