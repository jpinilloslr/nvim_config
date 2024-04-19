return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    question_header = '## Me ',
    answer_header = '## GLaDOS ',
    auto_follow_cursor = false,
    show_help = false,
    window = {
      layout = 'float',
      width = 0.8,
      height = 0.7,
      title = 'GLaDOS',
    },
    mappings = {
      reset = {
        normal = '<C-c>',
        insert = '<C-c>',
      },
    }
  },
}
