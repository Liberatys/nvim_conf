module NvimConf
  class Core
    def self.define(&block)
      new.instance_eval(&block)

      NvimConf::Writer.new(
        NvimConf.managers
      ).write
    end

    def plugins(name, title: nil, bootstraped: false, &block)
      evaluate_for_manager(
        Managers::Plugins.new(name, title, bootstraped: bootstraped),
        &block
      )
    end

    def globals(&block)
      evaluate_for_manager(
        Managers::Globals.new,
        &block
      )
    end

    def settings(title = nil, &block)
      evaluate_for_manager(
        Managers::Settings.new(title),
        &block
      )
    end

    def mappings(namespace = nil, &block)
      evaluate_for_manager(
        Managers::Mappings.new(namespace),
        &block
      )
    end

    def configuration(&block)
      evaluate_for_manager(
        Managers::CompilerConfigurations.new,
        &block
      )
    end

    private

    def evaluate_for_manager(manager, &block)
      manager.instance_eval(&block)
      store_manager(manager)
    end

    def store_manager(manager)
      return unless manager.store?

      NvimConf.managers.push(
        manager
      )
    end
  end
end
