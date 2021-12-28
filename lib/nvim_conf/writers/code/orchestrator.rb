require "nvim_conf/writers/code/settings"
require "nvim_conf/writers/code/requires"
require "nvim_conf/writers/code/globals"
require "nvim_conf/writers/code/commands"
require "nvim_conf/writers/code/mappings"
require "nvim_conf/writers/code/plugins/handler"

module NvimConf
  module Writers
    module Code
      class Orchestrator
        NON_WRITABLE_MANAGER = NvimConf::Managers::CompilerConfigurations

        WRITER_CONFIGURATION = {
          NvimConf::Managers::Settings => SettingsWriter,
          NvimConf::Managers::Mappings => MappingsWriter,
          NvimConf::Managers::Plugins => Code::Plugins::Handler,
          NvimConf::Managers::Globals => GlobalsWriter,
          NvimConf::Managers::Requires => RequiresWriter,
          NvimConf::Managers::Commands => CommandsWriter
        }

        def initialize(managers, io, configuration = nil)
          @managers = managers
          @io = io
          @configuration = configuration || default_configuration
        end

        def aggregate_writes
          @managers.reject do |manager|
            manager.instance_of?(NON_WRITABLE_MANAGER)
          end.each_with_index do |manager, index|
            @io.write(
              NvimConf::Commenter.comment_block(
                @configuration,
                manager_section_name(manager),
                spacer: index.positive?
              )
            )

            @io.write_separator if index.positive? || @configuration[:commented]

            aggregate_writes_for_manager(manager)
          end
        end

        private

        def manager_section_name(manager)
          return manager.class.section_name unless manager.respond_to?(:title)
          return manager.class.section_name if manager.title.nil?

          [
            manager.class.section_name,
            manager.title
          ].join(" - ")
        end

        def aggregate_writes_for_manager(manager)
          WRITER_CONFIGURATION[manager.class]&.new(manager, @io, @configuration)&.write
        end

        def default_configuration
          {
            format: :lua,
            commented: false
          }
        end
      end
    end
  end
end
