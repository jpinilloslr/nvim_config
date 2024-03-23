return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    name = 'GLaDOS',
    auto_follow_cursor = false,
    window = {
      layout = 'float',
      width = 0.8,
      height = 0.7,
      title = 'GLaDOS',
    },
  },
}
