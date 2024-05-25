local ls = require("luasnip")

ls.snippets = {
  latex {
    ls.snippet.basic({
      trig = "\\beg",
      dscr = "Begin snippet",
    }, {
      "\\begin{${1:env}}",
      "\t$0",
      "\\end{$1}",  
    }),

    ls.snippet.basic({
      trig = "\\sec",
      dscr = "Section snippet", 
    }, {
      "\\section{$1}",
      "$0", 
    })
  }
}

