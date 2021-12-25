module NvimConf
  module Writers
    module Code
      module Plugins
        class Packer
          BOOTSTRAP_HEADER = <<~BOOTSTRAP_HEADER
            local fn = vim.fn
            local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
            if fn.empty(fn.glob(install_path)) > 0 then
              packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
            end\n
          BOOTSTRAP_HEADER

          BOOTSTRAP_TAIL = <<~BOOTSTRAP_TAIL
            if packer_bootstrap then
                require('packer').sync()
              end
          BOOTSTRAP_TAIL

          BLOCK_START = <<~START
            return require('packer').startup(function()\n
          START

          BLOCK_END = <<~END
            end)
          END

          def initialize(manager, io, configuration)
            @manager = manager
            @io = io
            @configuration = configuration
            @plugins = manager.plugins
          end

          def write
            write_start_of_bootstrap
            @io.write(
              BLOCK_START
            )

            @plugins.each do |plugin|
              @io.write(
                "#{plugin_indent(@configuration[:generator].new(plugin).generate)}\n"
              )
            end

            write_tail_of_bootstrap

            @io.write(
              BLOCK_END
            )
          end

          private

          def write_start_of_bootstrap
            return unless bootstrap?

            @io.write(
              BOOTSTRAP_HEADER
            )
          end

          def write_tail_of_bootstrap
            return unless bootstrap?

            @io.write("\n")
            @io.write(
              plugin_indent(BOOTSTRAP_TAIL)
            )
            @io.write("\n")
          end

          def bootstrap?
            @manager.bootstraped
          end

          def plugin_indent(content)
            [
              " " * @configuration[:indent],
              content
            ].join
          end
        end
      end
    end
  end
end
