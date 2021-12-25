# TODO: This code needs to be refactored.... Bad CODE :D will be done during the addition of the second plugin manager!
module NvimConf
  module Writers
    module Code
      class PluginsWriter
        PLUGIN_MAP = {
          packer: NvimConf::Generators::Plugins::Code::Packer
        }

        INDENT_MAP = {
          packer: 2
        }

        def initialize(manager, io, _params)
          @manager = manager
          @io = io
        end

        def write
          send("surround_#{@manager.name}") do |plugin|
            @io.write(
              [
                plugin_indent(PLUGIN_MAP[@manager.name.to_sym].new(
                  plugin
                ).generate),
                "\n"
              ].join
            )
          end
        end

        private

        def surround_packer(&block)
          if bootstrap?
            @io.write(
              <<~BOOTSTRAP
                local fn = vim.fn
                local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
                if fn.empty(fn.glob(install_path)) > 0 then
                  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
                end\n
              BOOTSTRAP
            )
          end

          @io.write(
            "return require('packer').startup(function()\n"
          )

          @manager.plugins.each(&block)

          if bootstrap?
            @io.write("\n")
            @io.write(plugin_indent(
              <<~BOOTSTRAP
                if packer_bootstrap then
                    require('packer').sync()
                  end\n
              BOOTSTRAP
            ))
          end

          @io.write(
            "end)\n"
          )
        end

        def bootstrap?
          @manager.bootstraped
        end

        def plugin_indent(content)
          [
            " " * INDENT_MAP[@manager.name.to_sym],
            content
          ].join
        end

        def generator_class
          PLUGIN_MAP[@manager.name.to_sym]
        end
      end
    end
  end
end
