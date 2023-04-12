local front_matter = s("front_matter", {
  t { "---", "title: " }, i(1, "title"),
  t { "", "date: " }, f(function()
  return os.date('%Y-%m-%d %H:%M:%S', os.time()) .. ' +0800'
end, {}, {}),
  t { "", "categories: [", }, i(2), t "]",
  t { "", "tags: [", }, i(3), t "]",
  t { "", "img_path: /assets/img/" }, i(4),
  t { "", "---", "" },
})

return { front_matter, }
