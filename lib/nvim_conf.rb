# frozen_string_literal: true

require "nvim_conf/version"
require "nvim_conf/core"
require "nvim_conf/writer"
require "nvim_conf/configuration_builder"
require "nvim_conf/plugins/manager"
require "nvim_conf/settings/manager"
require "nvim_conf/utils/markdown_formatter"
require "nvim_conf/utils/io_operator"
require "nvim_conf/mappings/manager"
require "nvim_conf/compiler_configurations/manager"
require "nvim_conf/generators/code/settings/lua"
require "nvim_conf/generators/code/plugins/packer"
require "nvim_conf/generators/code/settings/vim"
require "nvim_conf/generators/code/mappings/lua"
require "nvim_conf/generators/code/mappings/vim"
require "nvim_conf/writers/code/orchestrator"
require "nvim_conf/writers/documentation/orchestrator"

module NvimConf
  @managers = []

  def self.managers
    @managers
  end

  def self.clear_managers
    @managers = []
  end

  class Error < StandardError; end
end
