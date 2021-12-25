require "nvim_conf/writers/code/settings"
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
          NvimConf::Managers::Plugins => Code::Plugins::Handler
        }

        def initialize(managers, io, configuration = nil)
          @managers = managers
          @io = io
          @configuration = configuration || default_configuration
        end

        def aggregate_writes
          @managers.select { |manager| manager.class != NON_WRITABLE_MANAGER }.each_with_index do |manager, index|
            @io.write(
              NvimConf::Commenter.comment_block(
                @configuration,
                manager.class.section_name,
                spacer: index.positive?
              )
            )

            if index.positive? || @configuration[:commented]
              @io.write(
                separator
              )
            end
            aggregate_writes_for_manager(manager)
          end
        end

        private

        def separator
          "\n\n"
        end

        def aggregate_writes_for_manager(manager)
          WRITER_CONFIGURATION[manager.class]&.new(
            manager, @io, **@configuration.slice(:format, :commented)
          )&.write
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
