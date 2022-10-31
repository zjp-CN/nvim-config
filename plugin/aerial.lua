require 'aerial'.setup {
  layout = {
    default_direction = "float",
    placement = "edge",
    min_width = { 40, 0.4 },
  },
  nerd_font = false,
  close_on_select =true,
  show_guides = true,
  float = {
    relative = "win",
    min_height = { 8, 0.5 },
  }
}
