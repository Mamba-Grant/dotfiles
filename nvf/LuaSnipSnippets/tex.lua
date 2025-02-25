local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local l = require("luasnip.extras").lambda
local r = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")
local pi = ls.parent_indexer
local isn = require("luasnip.nodes.snippet").ISN
local psn = require("luasnip.nodes.snippet").PSN
local l = require'luasnip.extras'.l
local r = require'luasnip.extras'.rep
local p = require("luasnip.extras").partial
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local su = require("luasnip.util.util")

-- https://ejmastnak.com/tutorials/vim-latex/luasnip/
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

-- This is the `get_visual` function I've been talking about.
-- ----------------------------------------------------------------------------
-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else  -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

local greek_letters = {
    a = "\\alpha", b = "\\beta", g = "\\gamma", d = "\\delta", ep = "\\epsilon",
    z = "\\zeta", et = "\\eta", th = "\\theta", io = "\\iota", k = "\\kappa",
    l = "\\lambda", m = "\\mu", nu = "\\nu", xi = "\\xi", omicron = "o",
    pi = "\\pi", r = "\\rho", s = "\\sigma", ta = "\\tau", u = "\\upsilon",
    phi = "\\phi", chi = "\\chi", psi = "\\psi", o = "\\omega",

    -- Uppercase Greek letters (LaTeX format)
    A = "\\Alpha", B = "\\Beta", G = "\\Gamma", D = "\\Delta", Ep = "\\Epsilon",
    Z = "\\Zeta", Et = "\\Eta", Th = "\\Theta", Io = "\\Iota", K = "\\Kappa",
    L = "\\Lambda", M = "\\Mu", Nu = "\\Nu", Xi = "\\Xi", Omicron = "O",
    Pi = "\\Pi", R = "\\Rho", S = "\\Sigma", Ta = "\\Tau", U = "\\Upsilon",
    Phi = "\\Phi", Chi = "\\Chi", Psi = "\\Psi", O = "\\Omega",
}

local snippets = {

    s({trig = "pp", dscr = "Add leftright parenthesis", snippetType="autosnippet"},
        fmta("\\left( <> \\right)",
            {d(1, get_visual) }
        )
    ),

    s({trig = "{", dscr = "Add leftright {}"},
        fmta("\\left\\{ <> \\right\\}",
            {d(1, get_visual) }
        )
    ),

    s({trig = "{", dscr = "Add leftright []"},
        fmta("\\left\\[ <> \\right\\]",
            {d(1, get_visual) }
        )
    ),

    s({trig = "dint", dscr = "Integral with bounds"},
        fmta("\\int_{<>}^{<>} <> \\,d<>",
            { i(1), i(2), d(3, get_visual), i(4), }
        )
    ),

    s({trig = "oint", dscr = "Integral with bounds"},
        fmta("\\oint_{<>}^{<>} <> \\,d<>",
            { i(1), i(2), d(3, get_visual), i(4), }
        )
    ),

    s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
        fmta("\\textit{<>}",
            { d(1, get_visual), }
        )
    ),

    s({trig = "bf", dscr = "Expands 'bf' into LaTeX's textbf{} command."},
        fmta("\\textbf{<>}",
            { d(1, get_visual), }
        )
    ),

    s({trig = "bs", dscr = "Expands 'bs' into LaTeX's boldsymbol{} command."},
        fmta("\\boldsymbol{<>}",
            { d(1, get_visual), }
        )
    ),

    s({trig = "==", snippetType="autosnippet"},
        { t("&="), }
    ),


    s({trig = "([^%a])mm", wordTrig = false, regTrig = true},
        fmta(
            "<>$<>$",
            { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual), }
        )
    ),

    s({trig = "([^%a])rd", wordTrig = false, regTrig = true},
        fmta(
            "<>e^{<>}",
            { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual), }
        )
    ),
    
    s({trig = "([^%a])sr", wordTrig = false, regTrig = true, snippetType="autosnippet"},
        fmta(
            "<>^{2}<>",
            { f( function(_, snip) return snip.captures[1] end ), i(1) }
        )
    ),
    
    s({trig = '([^%a])ee', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta(
            "<>e^{<>}",
            { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual) }
        )
    ),

    s({trig = "([^%a])sqrt", wordTrig = false, regTrig = true},
        fmta(
            "<>\\sqrt{<>}",
            { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual), }
        )
    ),

    s({trig = "ff", snippetType="autosnippet"},
        fmta(
            "\\frac{<>}{<>}",
            { d(1, get_visual), i(2), }),
        {  }
    ),

    s({
        trig = "([%w]+)%/",   -- Capture one or more alphanumeric characters before a slash
        regTrig = true,       -- Enable regex triggering
        snippetType = "autosnippet",
        wordTrig = false,     -- Allow triggering even if not at a word boundary
    },
        fmta(
            "\\frac{<>}{<>}", 
            {
                f(function(_, snip)
                    return snip.captures[1]  -- Use the captured text (word/number) as the numerator
                end),
                i(1)  -- Cursor for the denominator
            }
        ),
        {  }  -- Ensure the snippet only expands in a math zone
    ),


    s({trig = "-e", dscr='enumerate environment', snippetType="autosnippet"},
    fmta([[
    \begin{enumerate}[(a)]
        \item <>
    \end{enumerate}
    ]],
    { d(1, get_visual) }
    )),

    s({ trig='beg', name='begin/end', dscr='begin/end environment (generic)'},
    fmta([[
    \begin{<>}
    <>
    \end{<>}
    ]],
    { i(1), i(0), rep(1) }
    )),

    s({trig = 'cl',},
    fmta(
    [[
    \begin{callout}{Solution:}

    <>

    \end{callout}
    ]],
    { d(1, get_visual) }
    )),

    s({trig = '([^%a])aa', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta(
[[
\begin{align*}
    <>
\end{align*}
]],
            { d(1, get_visual) }
        )
    ),

    s({trig = '([^%a])gg', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta(
[[
\begin{gather*}
    <>
\end{gather*}
]],
            { d(1, get_visual) }
        )
    ),

        s({trig = '([^%a])bmat', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta( [[\begin{bmatrix} <> \end{bmatrix}]],
            { d(1, get_visual) }
        )
    ),

    s({trig = '([^%a])pmat', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta( [[\begin{pmatrix} <> \end{pmatrix}]],
            { d(1, get_visual) }
        )
    ),

    s({trig = '([^%a])mmat', regTrig = true, wordTrig = false, snippetType="autosnippet"},
        fmta( [[\begin{matrix} <> \end{matrix}]],
            { d(1, get_visual) }
        )
    ),

}

-- Add Greek letter snippets to the existing snippets table
for name, latex_cmd in pairs(greek_letters) do
    table.insert(snippets, 
        s({ trig = ';' .. name, snippetType = "autosnippet" },
          { t(latex_cmd), i(0) }  -- Insert text and place cursor at the end
        )
    )
end

table.insert(snippets,
    s({ trig = "([A-Za-z])(%d)", regTrig = true, wordTrig = false },
      fmta("<>_{<>}", { f(function(_, snip) return snip.captures[1] end), f(function(_, snip) return snip.captures[2] end) })
    )
)

return snippets
