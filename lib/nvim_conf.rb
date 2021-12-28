# frozen_string_literal: true

require "nvim_conf/version"
require "nvim_conf/core"
require "nvim_conf/manager"
require "nvim_conf/writer"
require "nvim_conf/commenter"
require "nvim_conf/configuration_builder"
require "nvim_conf/models/group"
require "nvim_conf/managers/plugins"
require "nvim_conf/managers/settings"
require "nvim_conf/managers/mappings"
require "nvim_conf/managers/requires"
require "nvim_conf/managers/globals"
require "nvim_conf/managers/commands"
require "nvim_conf/managers/compiler_configurations"
require "nvim_conf/utils/markdown_formatter"
require "nvim_conf/utils/io_operator"
require "nvim_conf/generators/code/settings/lua"
require "nvim_conf/generators/code/plugins/packer"
require "nvim_conf/generators/code/plugins/paq"
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
