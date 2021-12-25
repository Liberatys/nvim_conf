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
      end
    end
  end
end
