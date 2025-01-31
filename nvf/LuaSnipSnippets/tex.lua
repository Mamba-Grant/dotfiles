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

return {

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
    
    s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
        fmta(
            "<>e^{<>}",
            { f( function(_, snip) return snip.captures[1] end ), d(1, get_visual) }
        )
    ),

    s({trig = '([^%a])ff', regTrig = true, wordTrig = false},
        fmta(
            [[<>\frac{<>}{<>}]],
            { f( function(_, snip) return snip.captures[1] end ), i(1), i(2) }
        )
    ),
    s({trig = '([^%a])cl', regTrig = true, wordTrig = false},
        fmta(
[[
\begin{callout}{Solution:}
<>
\end{callout}
]],
            { f( function(_, snip) return snip.captures[1] end )}
        )
    ),

    s({trig = '([^%a])ali', regTrig = true, wordTrig = false},
        fmta(
[[
\begin{align*}
<>
\end{align*}
]],
            { f( function(_, snip) return snip.captures[1] end ), }
        )
    ),

    s({trig = '([^%a])gg', regTrig = true, wordTrig = false},
        fmta(
[[
\begin{gather*}
<>
\end{gather*}
]],
            { f( function(_, snip) return snip.captures[1] end ), }
        )
    ),

    s({trig = '([^%a])gg', regTrig = true, wordTrig = false},
        fmta(
[[
\begin{gather*}
<>
\end{gather*}
]],
            { f( function(_, snip) return snip.captures[1] end ), }
        )
    ),



}
