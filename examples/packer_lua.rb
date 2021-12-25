NvimConf::Core.define do
  configuration do
    output_folder "~/.config/nvim_conf/test"
    code_output :lua
    documented true
    write true
    commented
  end

  settings do
    set "tabstop"
  end

  mappings do
    nmap "<CTRL-c>", ":Git Blame"
  end

  plugins(:packer, bootstraped: true) do
    plug "glacambre/firenvim", opt: true, run: "cd folder"
    plug "glepnir/galaxyline.nvim", opt: true, branch: "main"
  end

  mappings(:nmap) do
    m "<CTRL-c>", ":Git Blame"
    m "<CTRL-c>", ":Git Blame"
  end
end
