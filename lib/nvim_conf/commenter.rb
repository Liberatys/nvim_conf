module NvimConf
  class Commenter
    class << self
      def comment_block(configuration, section, spacer: false)
        return if skip?(configuration)

        padded_title = section.center(20)
        border = "#" * (padded_title.length + 4)

        <<~FORMAT
          #{spacer ? "\n\n" : ""}
          -- #{border}
          -- # #{padded_title} #
          -- #{border}
        FORMAT
      end

      def skip?(configuration)
        configuration[:format] != :lua || !configuration[:commented]
      end
    end
  end
end
