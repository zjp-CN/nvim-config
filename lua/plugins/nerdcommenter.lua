local g = vim.g

-- Create default mappings
g.NERDCreateDefaultMappings = 1
-- Add spaces after comment delimiters by default
g.NERDSpaceDelims = 1
-- Use compact syntax for prettified multi-line comments
g.NERDCompactSexyComs = 1
g.NERDDefaultAlign = 'left'
-- Add your own custom formats or override the defaults
g.NERDCustomDelimiters = {
  rust = { left = [[//]], right = '', leftAlt = [[///]], rightAlt = '' },
  toml = { left = '#', right = '' }
}
-- Enable trimming of trailing whitespace when uncommenting
g.NERDTrimTrailingWhitespace = 1
-- Specifies if trailing whitespace should be deleted when uncommenting
g.NERDTrimTrailingWhitespace = 1
