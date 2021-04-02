local configs = require 'lspconfig/configs'

configs.anakin_language_server = {
  default_config = {
    cmd = {"anakinls"};
    filetypes = {"python"};
    root_dir = function(fname)
      return vim.fn.getcwd()
    end;
  };
  docs = {
    description = [[
https://github.com/muffinmad/anakin-language-server
`anakin-language-server`, a language server for Python, built on top of jedi
    ]];
    default_config = {
      root_dir = "vim's starting directory";
    };
  };
};
