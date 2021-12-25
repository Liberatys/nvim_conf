NvimConf::Core.define do
  plugins(:packer) do
    plug(:testing)
  end

  settings do
    set "tabstop"
  end
end
