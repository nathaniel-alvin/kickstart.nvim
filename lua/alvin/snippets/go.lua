require('luasnip.session.snippet_collection').clear_snippets 'go'

local ls = require 'luasnip'

local s = ls.snippet
local i = ls.insert_node

local fmt = require('luasnip.extras.fmt').fmt

ls.add_snippets('go', {
  s(
    'ec',
    fmt(
      [[
    if <> != nil {
        <>
    }
      ]],
      { i(1, 'err'), i(0) },
      { delimiters = '<>' }
    )
  ),
})
