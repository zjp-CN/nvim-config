local npairs = require('nvim-autopairs')
npairs.setup { map_cr = true } --> 没有映射 <CR> 的时候；如果 cmp 映射了 <CR>，需要按照官方说明设置

local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
npairs.add_rules({
  Rule("<", ">")
    -- don't add a pair if the next character is %
    :with_pair(cond.not_after_regex("%d"))
}
)
