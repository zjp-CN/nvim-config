local pr_inspect = "print(vim.inspect(${1}))"

return {
  parse("pr_inspect", pr_inspect),
}
