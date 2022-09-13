require 'diffview'.setup {
  use_icons = false,
  enhanced_diff_hl = true,
  default_args = {
    DiffviewOpen = { "--untracked-files=no", },
    DiffviewFileHistory = { "--base=LOCAL" },
  },
}
