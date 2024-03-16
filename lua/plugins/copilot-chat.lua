return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    name = 'GLaDOS',
    window = {
      layout = 'float',
      width = 0.8,
      height = 0.7,
      title = 'GLaDOS',
    },
    mappings = {
      close = 'q',
      reset = '<C-r>',
      complete = '<Tab>',
      submit_prompt = '<CR>',
      accept_diff = '<C-y>',
      show_diff = '<C-d>',
    },
  },
}
