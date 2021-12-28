[![Gem Version](https://badge.fury.io/rb/nvim_conf.svg)](https://badge.fury.io/rb/nvim_conf)

# NvimConf

A configuration manager for neovim that functions as an abstraction between your intentions and your configuration.
Functions in a way that prevents having to rewrite everything in order to change your plugin manager.

## Installation

```markdown
  gem install nvim_conf
  nvim_conf path_to_configuration_file
```

## Usage

```ruby
NvimConf::Core.define do
  plugins(:packer) do # add some plugins with any available plugin manager
    plug("tpope/vim-fugitive")
    plug("tpope/vim-surround")
  end

  requires do
    setup "nvim_lint"
    setup "tester"
  end

  configuration do # configurate the generation of code and documentation
    output_folder '$HOME/.config/nvim'
    code_output :lua # you want lua? you want vim? NO PROBLEM!
    documented true
    commented
  end

  settings do # define all your settings
    set "tabstop"
    unset "tabstop"
  end
end
```

### Output
#### Configuration

```lua
File: $HOME/.config/nvim/init.lua

require('packer').startup(function()
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
end)

require "nvim_lint".setup{}
require "tester".setup{}

vim.o.tabstop = true
vim.o.tabstop = false
```

#### Documentation

```markdown
File: $HOME/.config/nvim/Init.md

# Configuration Documentation Vim - NvimConf


## Settings
- tabstop => true
- tabstop => false
```
## Why use NvimConf?

### Abstraction

You no longer have to know about the exact syntax that vim and lua are handling calls to the api. One interface to configure them all.

This allows you to change your configuration without having to worry about a future language to configure vim... because we can just add the needed generators for the new langauge and your old configuration is good to go.

### Ruby

Because the abstraction is written in ruby and the configuration is also just a ruby file you are able to execute
any valid ruby code directly in your configuration. This allows you to introduce complex build tasks.

An example:

Input: 

```ruby
[
  :gzip,
  :zip,
  :zipPlugin,
  :tar,
  :tarPlugin,
  :getscript
].each do | setting|
  set "loaded_#{setting}", true
end
```

Output:

```lua
vim.g.loaded_gzip = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_getscript = true
```

Use environment variables, ruby helpers, modules and all the good that ruby has to offer.

Why repeat yourself when you can script it?

### **The goals of NvimConf are**

- Automatic documentation to your configuration
- Decoupling the configuration from the actual code needed to arrive at the configuration state
- Version control of generation schema rather than actual configuration
- No more file changes due to a change in package manager... just change the one line in your configuration generator
- Provide reproducible configuration
- Sharable and copiable configuration that allows everyone to configure their neovim
- Toolset to embed logic into your compiled configuration.

## Features to come

- Generators
  - More plugin managers
  - Auto Completion
  - Linters
- Configuraton optimization
  - Remove duplicate Plugins
  - Remove overwriting settings
- Param Checker
  - Validate the settings parameters
  - Check generated settings for functionality
- Split Configuraton into multiple files
- Render optimization by reducing the generation set
- Comment your configuration automatically
- Extend documentation generation
  - Options for styling / spacing
- Meta information for your configuration
  - Version
  - Author-Name
  - Generation Date
  - Generation Architecture (Macos / Linux)
- Utility to share and donwload configurations

## Examples

You can find more examples of configurations here: [example folder](./examples)
