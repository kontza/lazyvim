local ls = require("luasnip")
return {
  ls.snippet({ trig = "jrnltimestamp", desc = "Insert a jrnl compliant timestamp" }, {
    ls.text_node(
      os.date("%Y")
        .. "-"
        .. os.date("%m")
        .. "-"
        .. os.date("%d")
        .. " "
        .. os.date("%a")
        .. " "
        .. os.date("%H")
        .. ":"
        .. os.date("%M")
    ),
  }),
}
