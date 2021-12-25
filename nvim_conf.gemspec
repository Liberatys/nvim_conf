# frozen_string_literal: true

$LOAD_PATH << File.expand_path("lib", __dir__)

require_relative "lib/nvim_conf/version"

Gem::Specification.new do |spec|
  spec.name = "nvim_conf"
  spec.version = NvimConf::VERSION
  spec.authors = ["Liberatys"]
  spec.email = ["nick.flueckiger@renuo.ch"]

  spec.summary = "A ruby dsl to generate a nvim configuration"
  spec.description = "A ruby dsl to generate a nvim configuration"
  spec.homepage = "https://github.com/Liberatys/nvim_conf"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Liberatys/nvim_conf"
  spec.metadata["changelog_uri"] = "https://github.com/Liberatys/nvim_conf"
  spec.files = Dir.glob("lib/**/*") + %w[LICENSE.txt README.md]

  spec.executables = "nvim_conf"
  spec.require_paths = ["lib"]
end
