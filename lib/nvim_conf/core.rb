module NvimConf
  class Core
    def self.define(&block)
      new.instance_eval(&block)

      NvimConf::Writer.new(
        NvimConf.managers
      ).write
    end

    def plugins(name, bootstraped: false, &block)
      store_manager(
        evaluate_for_manager(
          Plugins::Manager.new(name, bootstraped: bootstraped),
          &block
        )
      )
    end

    def settings(&block)
      store_manager(evaluate_for_manager(
        Settings::Manager.new,
        &block
      ))
    end

    def mappings(namespace = nil, &block)
      store_manager(evaluate_for_manager(
        Mappings::Manager.new(namespace),
        &block
      ))
    end

    def configuration(&block)
      store_manager(evaluate_for_manager(
        CompilerConfigurations::Manager.new,
        &block
      ))
    end

    private

    def evaluate_for_manager(manager, &block)
      manager.instance_eval(&block)
      manager
    end

    def store_manager(manager)
      return unless manager.store?

      NvimConf.managers.push(
        manager
      )
    end
  end
end
