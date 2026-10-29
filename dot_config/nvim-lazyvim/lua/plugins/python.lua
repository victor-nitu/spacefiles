return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- Ruff via pylsp plugin
                ruff = {
                  enabled = true,
                  lineLength = 120,
                  ignore = { "E501" },
                },
                pycodestyle = {
                  enabled = false,
                  maxLineLength = 120,
                  ignore = { "E501" },
                },
                pyflakes = { enabled = true },
                mccabe = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
              },
            },
          },
        },
        -- remove ruff_lsp from servers if you go with pylsp-ruff
      },
    },
  },
}
