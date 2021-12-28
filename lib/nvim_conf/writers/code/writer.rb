module NvimConf
  module Writers
    module Code
      class BaseWriter
        def initialize(manager, io, configuration)
          @manager = manager
          @io = io
          @configuration = configuration
        end

        def write
          @manager.relevant_groups.each do |group|
            @io.write_group(@manager, group)

            group.children.each do |setting|
              @io.write(
                [
                  generator_class.new(setting).generate,
                  "\n"
                ].join
              )
            end
          end
        end

        def generator_class
          raise "generator_class not implemented"
        end
      end
    end
  end
end
