local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_keylocal date = function() return {os.date('%Y-%m-%d')} end

ls.config.setup({ enable_autosnippets = true })

local function simple_restore(args, _)
	return sn(nil, {i(1, args[1]), r(2, "dyn", i(nil, ""))})
end

local function fn(
  args,     -- text from i(2) in this example i.e. { { "456" } }
  parent,   -- parent snippet or parent node
  user_args -- user_args from opts.user_args 
)
   return '' .. args[1][1] .. user_args .. ''
end

-- SNIPPETS
ls.add_snippets("jl", {})

ls.add_snippets("tex", {

-- Greek letters
s({ trig = "@a", snippetType = "autosnippet" }, fmt([[
\alpha 
]], {} )),
s({ trig = "@A", snippetType = "autosnippet" }, fmt([[
\alpha 
]], {} )),
s({ trig = "@b", snippetType = "autosnippet" }, fmt([[
\beta 
]], {} )),
s({ trig = "@B", snippetType = "autosnippet" }, fmt([[
\beta 
]], {} )),
s({ trig = "@c", snippetType = "autosnippet" }, fmt([[
\chi 
]], {} )),
s({ trig = "@C", snippetType = "autosnippet" }, fmt([[
\chi 
]], {} )),
s({ trig = "@g", snippetType = "autosnippet" }, fmt([[
\gamma 
]], {} )),
s({ trig = "@G", snippetType = "autosnippet" }, fmt([[
\Gamma 
]], {} )),
s({ trig = "@d", snippetType = "autosnippet" }, fmt([[
\delta 
]], {} )),
s({ trig = "@D", snippetType = "autosnippet" }, fmt([[
\Delta 
]], {} )),
s({ trig = "@e", snippetType = "autosnippet" }, fmt([[
\epsilon 
]], {} )),
s({ trig = "@E", snippetType = "autosnippet" }, fmt([[
\epsilon 
]], {} )),
s({ trig = ":e", snippetType = "autosnippet" }, fmt([[
\varepsilon 
]], {} )),
s({ trig = ":E", snippetType = "autosnippet" }, fmt([[
\varepsilon 
]], {} )),
s({ trig = "@z", snippetType = "autosnippet" }, fmt([[
\zeta 
]], {} )),
s({ trig = "@Z", snippetType = "autosnippet" }, fmt([[
\zeta 
]], {} )),
s({ trig = "@t", snippetType = "autosnippet" }, fmt([[
\theta 
]], {} )),
s({ trig = "@T", snippetType = "autosnippet" }, fmt([[
\Theta 
]], {} )),
s({ trig = "@k", snippetType = "autosnippet" }, fmt([[
\kappa 
]], {} )),
s({ trig = "@K", snippetType = "autosnippet" }, fmt([[
\kappa 
]], {} )),
s({ trig = "@l", snippetType = "autosnippet" }, fmt([[
\lambda 
]], {} )),
s({ trig = "@L", snippetType = "autosnippet" }, fmt([[
\Lambda 
]], {} )),
s({ trig = "@m", snippetType = "autosnippet" }, fmt([[
\mu 
]], {} )),
s({ trig = "@M", snippetType = "autosnippet" }, fmt([[
\mu 
]], {} )),
s({ trig = "@r", snippetType = "autosnippet" }, fmt([[
\rho 
]], {} )),
s({ trig = "@R", snippetType = "autosnippet" }, fmt([[
\rho 
]], {} )),
s({ trig = "@s", snippetType = "autosnippet" }, fmt([[
\sigma 
]], {} )),
s({ trig = "@S", snippetType = "autosnippet" }, fmt([[
\Sigma 
]], {} )),
s({ trig = "ome", snippetType = "autosnippet" }, fmt([[
\omega 
]], {} )),
s({ trig = "@o", snippetType = "autosnippet" }, fmt([[
\omega 
]], {} )),
s({ trig = "@O", snippetType = "autosnippet" }, fmt([[
\Omega 
]], {} )),

-- Operations
s({ trig = "b{%d}", regTrig = true, snippetType="autosnippet" },
	f(function(args, snip) return
		"Captured Text: " .. snip.captures[1] .. "." end, {})
),
s({ trig = "ov" }, fmt([[
\overline{<>}
]], { i(1) }, { delimiters = "<>" } )),
s({ trig = "frac" }, fmt([[
\frac{<>}{<>}
]], { i(1), i(2) }, { delimiters = "<>"} )),
s({ trig = "rm", snippetType="autosnippet" }, fmt([[
\textrm{<>}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "bf", snippetType="autosnippet" }, fmt([[
\textbf{<>}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "bb", snippetType="autosnippet" }, fmt([[
\textbb{<>}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "_", snippetType="autosnippet" }, fmt([[
_{<>}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "rd", snippetType="autosnippet" }, fmt([[
^{<>}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "sr" }, fmt([[
^{2}
]], {}, { delimiters = "<>"} )),
s({ trig = "sq" }, fmt([[
\sqrt{ <> }
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "cb", snippetType="autosnippet" }, fmt([[
^{3}
]], {}, { delimiters = "<>"} )),
s({ trig = "pow", snippetType="autosnippet" }, fmt([[
 \times 10^{<>}
]], {i(1)}, { delimiters = "<>"} )),
s({ trig = "det" }, fmt([[
\det
]], {}, { delimiters = "<>"} )),
s({ trig = "sin" }, fmt([[
\sin
]], {}, { delimiters = "<>" } )),
s({ trig = "cos" }, fmt([[
\cos
]], {}, { delimiters = "<>" } )),
s({ trig = "expect" }, fmt([[
\langle <> \rangle
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "set" }, fmt([[
\{ <> \}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "()" }, fmt([[
\left( <> \right)
]], { i(1) }, { delimiters = "<>"} )),


-- Environments

s({ trig = "begin"}, fmt([[
\begin{{{a}}}
    {b}
\end{{{a}}}
]], { a = i(1, "repeat"), b = i(2) }, { repeat_duplicates = true } )),
s({ trig = "multicols"}, fmt([[
\begin{multicols}{<>}
    <>
\end{multicols}
]], { i(1, "2"), i(2) }, { delimiters = "<>"} )),
s({ trig = "enumerate"}, fmt([[
\begin{enumerate}[<>]
    \item <>
\end{enumerate}
]], { i(1, "1."), i(2) }, { delimiters = "<>"} )),
s({ trig = "itemize"}, fmt([[
\begin{itemize}
    \item <>
\end{itemize}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "sec"}, fmt([[
\section{<>}
<>
]], { i(1), i(2) }, { delimiters = "<>"} )),
s({ trig = "ali", snippetType="autosnippet" }, fmt([[
\begin{align*}
    <>
\end{align*}
]], { i(1) }, { delimiters = "<>"} )),
s({ trig = "bmat", snippetType="autosnippet" }, fmt([[
\begin{bmatrix} <> \end{bmatrix}
]],{ i(1) }, {delimiters = "<>"} )),
s({ trig = "pmat", snippetType="autosnippet" }, fmt([[
\begin{pmatrix} <> \end{pmatrix}
]],{ i(1) }, {delimiters = "<>"} )),
s({ trig = "smat", snippetType="autosnippet" }, fmt([[
\left[\begin{smallmatrix} <> \end{smallmatrix}\right]
]],{ i(1) }, {delimiters = "<>"} )),
s({ trig = "array" }, fmt([[
\begin{array}{<>} <> \end{array}
]],{ i(1, "c"), i(2) }, {delimiters = "<>"} )),
s({ trig = "==", snippetType="autosnippet" }, fmt([[
&=
]],{}, {delimiters = "<>"} )),
s({ trig = "cl" }, fmt([[
\begin{callout}{<>}
    <>
\end{callout}
]],{ i(1, "Solution:"), i(2) }, {delimiters = "<>"} )),
s({ trig = "enum" }, fmt([[
\begin{enumerate}
    \item <>
\end{enumerate}
]],{ i(1) }, {delimiters = "<>"} )),
s({ trig = "$", snippetType="autosnippet" }, fmt([[
$<>$
]],{ i(1) }, {delimiters = "<>"} )),

-- Symbols
s({ trig = "lt", snippetType="autosnippet" }, fmt([[
<
]], {}, {} )),
s({ trig = "gt", snippetType="autosnippet" }, fmt([[
>
]], {}, {} )),
s({ trig = "leq", snippetType="autosnippet" }, fmt([[
\leq
]], {}, {} )),
s({ trig = "geq", snippetType="autosnippet" }, fmt([[
\geq
]], {}, {} )),

-- Calculus
s({ trig = "par" }, fmt([[
\frac{\partial <>}{\partial <>}
]],{ i(1), i(2) }, {delimiters = "<>"} )),
s({ trig = "oint" }, fmt([[
\int_{0}^{\infty} <> ~d<>
]],{ i(1), i(2, "x") }, {delimiters = "<>"} )),
s({ trig = "dint" }, fmt([[
\int_{<>}^{<>} <> ~d<>
]],{ i(1, "a"), i(2, "b"), i(3), i(4, "x") }, {delimiters = "<>"} )),
s({ trig = "int" }, fmt([[
\int <> ~d<>
]],{ i(1), i(2, "x") }, {delimiters = "<>"} )),

-- Quantum Mechanics
s({ trig = "hba", snippetType="autosnippet" }, fmt([[
\hbar
]],{}, {delimiters = "<>"} )),

-- Template
s({ trig = "tmplt" }, fmt([[
\documentclass{article}


\newcommand{\hmwkTitle}{<>}
\newcommand{\hmwkDueDate}{\today}
\newcommand{\hmwkClass}{<>}
\newcommand{\hmwkAuthorName}{\textbf{Grant Saggars}}



\usepackage{fancyhdr}
\usepackage{extramarks}
\usepackage{amsmath}
\usepackage{amsthm}
\usepackage{amsfonts}
\usepackage{tikz}

\usepackage{float}
\usepackage{caption}
\usepackage{bbold}
\usepackage{xcolor}
\usepackage{framed}
\usepackage{enumerate}
\usepackage{cancel}
\usepackage{multicol}
\usepackage{XCharter}

\usetikzlibrary{automata,positioning}

\usepackage{geometry}
\geometry{top=1in, bottom=1in, left=1in, right=1in} % Adjust margins as needed

\pagestyle{fancy}
\lhead{\hmwkAuthorName}
\chead{\hmwkClass\: \hmwkTitle}
\rhead{\firstxmark}
\lfoot{\lastxmark}
\cfoot{\thepage}

%
% Basic Document Settings
%

\topmargin=-0.75in
\evensidemargin=0in
\oddsidemargin=0in
\textwidth=6.5in
\textheight=9.0in
\headsep=0.25in

\linespread{1.1}

\renewcommand\headrulewidth{0.4pt}
\renewcommand\footrulewidth{0.4pt}

\setlength\parindent{0pt}

%
% Create Problem Sections
%

\newcommand{\enterProblemHeader}[1]{
    \nobreak\extramarks{}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
    \nobreak\extramarks{Problem \arabic{#1} (continued)}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
}

\newcommand{\exitProblemHeader}[1]{
    \nobreak\extramarks{Problem \arabic{#1} (continued)}{Problem \arabic{#1} continued on next page\ldots}\nobreak{}
    \stepcounter{#1}
    \nobreak\extramarks{Problem \arabic{#1}}{}\nobreak{}
}

\setcounter{secnumdepth}{0}
\newcounter{partCounter}
\newcounter{homeworkProblemCounter}
\setcounter{homeworkProblemCounter}{1}
\nobreak\extramarks{Problem \arabic{homeworkProblemCounter}}{}\nobreak{}

%
% Homework Problem Environment
%
% This environment takes an optional argument. When given, it will adjust the
% problem counter. This is useful for when the problems given for your
% assignment aren't sequential. See the last 3 problems of this template for an
% example.
%
\newenvironment{homeworkProblem}[1][-1]{
    \ifnum#1>>0
        \setcounter{homeworkProblemCounter}{#1}
    \fi
    \section{Problem \arabic{homeworkProblemCounter}}
    \setcounter{partCounter}{1}
    \enterProblemHeader{homeworkProblemCounter}
}{
    \exitProblemHeader{homeworkProblemCounter}
}

%
% Callout Box
%

\definecolor{shadecolor}{RGB}{235,235,235}
\newenvironment{callout}[1] {\begin{shaded*} \textbf{#1}} {\end{shaded*}}

%
% Title Page
%

\title{
    \textmd{\textbf{\hmwkClass:\ \hmwkTitle}}\\
    \normalsize\vspace{0.1in}\small{\hmwkDueDate}\\
}

\author{\hmwkAuthorName}
\date{}

\renewcommand{\part}[1]{\textbf{\large Part \Alph{partCounter}}\stepcounter{partCounter}\\}





\begin{document}

\maketitle

<>

\end{document}]],{ i(1, "Homework"), i(2, "Class"), i(3) }, {delimiters = "<>"} )),
})

