require "fileutils"

module NvimConf
  class Writer
    def initialize(managers)
      @managers = managers
      @configuration = NvimConf::ConfigurationBuilder.new(managers).build_configuration
    end

    def write
      return unless run?

      create_folder
      write_configuration
      write_documentation
    end

    private

    def run?
      @configuration[:write]
    end

    def write_documentation
      create_documentation_init

      File.open(documentation_file_path, "w+") do |file|
        NvimConf::Writers::Documentation::Orchestrator.new(
          @managers,
          file,
          @configuration
        ).aggregate_writes
      end
    end

    def create_folder
      FileUtils.mkdir_p(folder_path)
    end

    def create_documentation_init
      FileUtils.remove_file(
        documentation_file_path,
        force: true
      )
      FileUtils.touch(
        documentation_file_path
      )
    end

    def create_init
      FileUtils.remove_file(
        init_file_path,
        force: true
      )
      FileUtils.touch(
        init_file_path
      )
    end

    def write_configuration
      create_init
      File.open(init_file_path, "w+") do |file|
        NvimConf::Writers::Code::Orchestrator.new(
          @managers,
          file,
          @configuration
        ).aggregate_writes
      end
    end

    def documentation_file_path
      folder_path + "Init.md"
    end

    def init_file_path
      folder_path + init_file_name
    end

    def init_file_name
      @configuration[:schema] == :nvim ? "init.lua" : "init.vim"
    end

    def folder_path
      @folder_path = Pathname.new(@configuration[:output_folder]).expand_path
    end
  end
end
