require "nvim_conf/managers/compiler_configurations"

module NvimConf
  class ConfigurationBuilder
    CONFIGURATION_MANAGER = NvimConf::Managers::CompilerConfigurations

    def initialize(managers)
      @managers = managers
      @configuration = default_configuration
    end

    def build_configuration
      @managers.select { |manager| manager.instance_of?(CONFIGURATION_MANAGER) }.each do |manager|
        manager.configurations.each do |configuration|
          @configuration[configuration.name] = configuration.value
        end
      end

      @configuration[:format] ||= @configuration[:schema] == :nvim ? :lua : :vim
      @configuration
    end

    private

    def default_configuration
      {
        output_folder: "$HOME/.config/nvim",
        code_output: :lua,
        write: false,
        mono_file: true,
        documented: false,
        commented: true,
        schema: :nvim
      }
    end
  end
end
