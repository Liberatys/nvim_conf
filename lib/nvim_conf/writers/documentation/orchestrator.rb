require "nvim_conf/writers/documentation/mappings"
require "nvim_conf/writers/documentation/globals"
require "nvim_conf/writers/documentation/settings"
require "nvim_conf/writers/documentation/plugins"

module NvimConf
  module Writers
    module Documentation
      class Orchestrator
        NON_WRITABLE_MANAGER = NvimConf::Managers::CompilerConfigurations

        def initialize(managers, io, configuration = nil)
          @managers = managers
          @io = io
          @configuration = configuration || default_configuration
        end

        def aggregate_writes
          return unless @configuration[:documented]

          write_main_header

          writers = [
            [
              NvimConf::Writers::Documentation::Settings, NvimConf::Managers::Settings
            ],
            [
              NvimConf::Writers::Documentation::Mappings, NvimConf::Managers::Mappings
            ],
            [
              NvimConf::Writers::Documentation::Plugins, NvimConf::Managers::Plugins
            ],
            [
              NvimConf::Writers::Documentation::Globals, NvimConf::Managers::Globals
            ]
          ]

          writers.each_with_index do |relevant_classes, index|
            writer_class, manager_class = *relevant_classes
            managers = @managers.select { |manager| manager.instance_of?(manager_class) }

            next if managers.length.zero?

            writer_class.new(
              managers,
              @io
            ).aggregate_writes

            @io.write("\n\n") if index != (writers.length - 1)
          end
        end

        private

        def write_main_header
          @io.write(
            "# Configuration Documentation Vim - NvimConf\n\n"
          )
        end
      end
    end
  end
end
