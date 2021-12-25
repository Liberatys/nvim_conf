require "nvim_conf/models/compiler_configuration"

module NvimConf
  module Managers
    class CompilerConfigurations
      attr_reader :configurations

      def initialize
        @configurations = []
      end

      def store?
        @configurations.any?
      end

      def output_folder(path)
        store_configuration(
          :output_folder,
          path
        )
      end

      def write(acceptance = true)
        store_configuration(
          :write,
          acceptance
        )
      end

      def code_output(language)
        store_configuration(
          :code_output,
          language.to_s
        )
      end

      def mono_file(acceptance = true)
        store_configuration(
          :mono_file,
          acceptance
        )
      end

      def documented(formats)
        store_configuration(
          :documented,
          formats
        )
      end

      def commented(acceptance = true)
        store_configuration(
          :commented,
          acceptance
        )
      end

      private

      def store_configuration(name, value)
        @configurations << build_configuration(
          name, value
        )
      end

      def build_configuration(name, value)
        Models::CompilerConfiguration.new(
          name,
          value
        )
      end
    end
  end
end
