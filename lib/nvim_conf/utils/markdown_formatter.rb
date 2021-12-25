module NvimConf
  module Utils
    class MarkdownFormatter
      class << self
        def collapisible(summary, content)
          <<~FORMAT
            <details>
              <summary>
                #{summary}
              </summary>

              #{content}
            </details>
          FORMAT
        end

        def separator(count: 2)
          "\n" * count
        end

        def format_title(title, level: 0, indent: 0)
          prefix = [
            indent.positive? ? " " * indent : nil,
            level != 0 ? "#" * level : nil
          ].compact.join

          [
            prefix,
            "#{title}\n\n"
          ].compact.join(" ")
        end
      end
    end
  end
end
