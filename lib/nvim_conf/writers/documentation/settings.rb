module NvimConf
  module Writers
    module Documentation
      class Settings
        def initialize(managers, io)
          @managers = managers
          @io = io
        end

        def aggregate_writes
          return if @managers.empty?

          @io.write(
            Utils::MarkdownFormatter.format_title(
              "Settings",
              level: 2
            )
          )

          write_settings_groups(all_settings.group_by(&:operation))
        end

        private

        def write_settings_groups(groups)
          groups.each do |operation, settings|
            @io.write_separator

            @io.write(
              Utils::MarkdownFormatter.format_title(
                operation.capitalize,
                level: 3
              )
            )

            settings.each do |setting|
              @io.write(
                [
                  "- #{setting.key}",
                  transformed_value(setting, setting.value)
                ].join(operator(setting)) + "\n"
              )
            end
          end
        end

        def operator(setting)
          %i[set unset].include?(setting.operation) ? " => " : " += "
        end

        def transformed_value(setting, value)
          return value.join(", ") if value.is_a?(Array)
          return value unless value.nil?

          setting.operation == :set
        end

        def all_settings
          @managers.map(&:all_children).flatten
        end
      end
    end
  end
end
