lua << EOF
-- Customized config
require("nvim-gps").setup({

	disable_icons = true,           -- Setting it to true will disable all icons

	--icons = {
	--	["class-name"] = 'Class: ',      -- Classes and class-like objects
	--	["function-name"] = 'Function: ',   -- Functions
	--	["method-name"] = 'Method: ',     -- Methods (functions inside class-like objects)
	--	["container-name"] = 'Container: ',  -- Containers (example: lua tables)
	--	["tag-name"] = 'Tag: '         -- Tags (example: html tags)
	--},

	-- Add custom configuration per language or
	-- Disable the plugin for a language
	-- Any language not disabled here is enabled by default
	languages = {
		-- Some languages have custom icons
		["json"] = {
			icons = {
				["array-name"] = 'Array: ',
				["object-name"] = 'Object: ',
				["null-name"] = 'Null: ',
				["boolean-name"] = 'Bool: ',
				["number-name"] = '#',
				["string-name"] = 'Str: '
			}
		},
		["toml"] = {
			icons = {
				["table-name"] = 'Table: ',
				["array-name"] = 'Array: ',
				["boolean-name"] = 'Bool: ',
				["date-name"] = 'Date: ',
				["date-time-name"] = 'DateTime: ',
				["float-name"] = 'Float: ',
				["inline-table-name"] = 'Inline-Table: ',
				["integer-name"] = '# ',
				["string-name"] = 'Str: ',
				["time-name"] = 'Time: '
			}
		},
		["yaml"] = {
			icons = {
				["mapping-name"] = ' ',
				["sequence-name"] = ' ',
				["null-name"] = '[] ',
				["boolean-name"] = 'ﰰﰴ ',
				["integer-name"] = '# ',
				["float-name"] = ' ',
				["string-name"] = ' '
			}
		},
        -- 这里的 query 似乎落后了
        -- https://github.com/SmiteshP/nvim-gps/blob/master/queries/rust/nvimGPS.scm
        ["rust"] = {
            icons = {
                ["struct-name"] = 'Struct: ',
                ["impl-name"] = 'Impl: ',
                ["function-name"] = 'Fn: ',
                ["enum-name"] = 'Enum: ',
                ["mod-name"] = 'Mod: ',
                ["impl-with-generic-name"] = 'ImplG: ',
            }
        },

		-- Disable for particular languages
		-- ["bash"] = false, -- disables nvim-gps for bash
		-- ["go"] = false,   -- disables nvim-gps for golang

		-- Override default setting for particular languages
		-- ["ruby"] = {
		--	separator = '|', -- Overrides default separator with '|'
		--	icons = {
		--		-- Default icons not specified in the lang config
		--		-- will fallback to the default value
		--		-- "container-name" will fallback to default because it's not set
		--		["function-name"] = '',    -- to ensure empty values, set an empty string
		--		["tag-name"] = ''
		--		["class-name"] = '::',
		--		["method-name"] = '#',
		--	}
		--}
	},

	separator = ' > ',

	-- limit for amount of context shown
	-- 0 means no limit
	-- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
	-- in context names (eg: function names, class names, etc)
	depth = 4,

	-- indicator used when context is hits depth limit
	depth_limit_indicator = ".."
})
EOF

lua << END
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end
local function window()
  return vim.api.nvim_win_get_number(0)
end
local gps = require("nvim-gps")
require'lualine'.setup {
    options = {icons_enabled = false, theme = 'nord'},
    sections = {
        -- lualine_a = { {'mode'}, {window}, },
        lualine_b = { 
            -- {'b:gitsigns_status'},
            -- {'b:gitsigns_head', icon = ''}, 
            'branch', {'diff', source = diff_source}
        },
        lualine_c = {
           -- {'diff', source = diff_source}, 
           'diagnostics',
            { 'filename', path = 1 },
  --         { gps.get_location, cond = gps.is_available },
           -- {
           --   'diagnostics',

           --   -- Table of diagnostic sources, available sources are:
           --   --   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
           --   -- or a function that returns a table as such:
           --   --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
           --   sources = { 'nvim_diagnostic' },

           --   -- Displays diagnostics for the defined severity types
           --   sections = { 'error', 'warn', 'info', 'hint' },

           --   diagnostics_color = {
           --     -- Same values as the general color option can be used here.
           --     error = 'DiagnosticError', -- Changes diagnostics' error color.
           --     warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
           --     info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
           --     hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
           --   },
           --   symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
           --   colored = true,           -- Displays diagnostics status in color if set to true.
           --   update_in_insert = false, -- Update diagnostics in insert mode.
           --   always_visible = false,   -- Show diagnostics even if there are none.
           --},
           { 'lsp_progress',
               display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
               timer = { progress_enddelay = 2000, spinner = 1000, lsp_client_name_enddelay = 2500 }
           }, 
        },
        lualine_x = {'encoding', 'filetype'},
    }
}
END

