module NvimConf
  class Manager
    NO_GROUP_DEFAULT_NAME = "No Group"

    attr_reader :groups

    def initialize
      @groups = default_groups
      @current_group = nil
    end

    def group(name, label: nil, &block)
      new_group(name, label)

      instance_eval(&block)
    end

    def all_children
      @groups.map(&:children).flatten
    end

    def relevant_groups
      @groups.select { |group| group.children.length.positive? }
    end

    private

    def new_child(child)
      current_group.children << child
    end

    def current_group
      @current_group.nil? ? find_no_group : @current_group
    end

    def find_no_group
      @groups.find { |group| group.name == NO_GROUP_DEFAULT_NAME }
    end

    def store?
      @groups.any? { |group| group.children.length.positive? }
    end

    def new_group(name, label)
      group = Models::Group.new(
        name,
        label
      )
      @groups << group
      @current_group = group
    end

    def default_groups
      [
        Models::Group.new(
          NO_GROUP_DEFAULT_NAME
        )
      ]
    end
  end
end
