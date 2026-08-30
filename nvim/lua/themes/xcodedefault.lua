---@class Config
local config = {
  opt = {
    integrations = {
      telescope = false,
      lualine = true,
      lsp_semantics_token = true,
      nvim_cmp = true,
      dap_nvim = true,
    },
  },
}

---@class MyModule
local M = {}

---@type Config
M.config = config

-- Hybrid: xcodedark backgrounds + nvim-default color philosophy
--   default-dark:  Keywords=Yellow bold,  Constants=Magenta,  Strings=Magenta,
--                  Types=Green bold,       Functions=Cyan,     PreProc=Magenta
--   xcodedark supplies every hex value; bold/italic modifiers come from default.
local color = {
  -- ── Backgrounds (xcodedark) ────────────────────────────────────────────
  background   = "#292a30",
  dark         = "#1e1f24",
  selection    = "#393b44",
  inactive_bg  = "#212226",
  cursor_line  = "#2d2f36",
  medium_gray  = "#3a3c44",

  -- ── Foregrounds (xcodedark) ────────────────────────────────────────────
  foreground   = "#dfdfe0",
  light_gray   = "#a3b1bf",

  -- ── Comment: brighter than pure xcode gray so it reads like default cyan
  comment      = "#6b8a9e",

  -- ── Syntax — mapped to default's color roles ───────────────────────────
  -- default: Statement/Keyword = Yellow bold  → xcode yellow
  yellow       = "#ffa14f",
  -- default: Constant/String/Number = Magenta → xcode purple / light-purple
  purple       = "#b281eb",
  light_purple = "#dabaff",
  -- default: Identifier/Function = Cyan       → xcode teal / light-teal
  teal         = "#78c2b3",
  light_teal   = "#acf2e4",
  -- default: Type = Green bold                → xcode green / light-green
  green        = "#84b360",
  light_green  = "#b0e687",
  -- default: PreProc = Magenta (bright)       → xcode pink
  pink         = "#ff7ab2",
  -- default: Special = DarkCyan              → xcode light-blue
  light_blue   = "#6bdfff",
  blue         = "#4eb0cc",
  -- default: Error = Red                     → xcode red
  red          = "#ff8170",
  -- extras
  light_yellow = "#d9c97c",
}

---@param args Config?
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  if vim.g.colors_name ~= nil then
    vim.cmd("highlight clear")
  end

  if args and type(args.override) == "function" then
    local c = args.override(color)
    color = vim.tbl_deep_extend("force", color, c)
  end

  if vim.fn.has("nvim-0.8.3") == 0 then
    vim.cmd("echohl WarningMsg | echo 'nvim >= 0.8.3 required' | echohl None")
  end

  vim.g.colors_name = "xcodedefault"
  vim.o.termguicolors = true
  M.configure_highlights()
end

M.configure_highlights = function()
  local hi = vim.api.nvim_set_hl

  -- ── LSP semantic tokens ───────────────────────────────────────────────────
  if M.config.opt.integrations.lsp_semantics_token then
    hi(0, "@attribute",                           { link = "TSAttribute" })
    hi(0, "@boolean",                             { link = "TSBoolean" })
    hi(0, "@character",                           { link = "TSCharacter" })
    hi(0, "@character.special",                   { link = "SpecialChar" })
    hi(0, "@class",                               { link = "TSType" })
    hi(0, "@comment",                             { link = "TSComment" })
    hi(0, "@conditional",                         { link = "TSConditional" })
    hi(0, "@constant",                            { link = "TSConstant" })
    hi(0, "@constant.builtin",                    { link = "TSConstantBuiltin" })
    hi(0, "@constant.macro",                      { link = "TSConstant" })
    hi(0, "@constructor",                         { link = "TSConstructor" })
    hi(0, "@decorator",                           { link = "TSAttribute" })
    hi(0, "@enum",                                { link = "TSType" })
    hi(0, "@enumMember",                          { link = "TSConstant" })
    hi(0, "@error",                               { link = "TSError" })
    hi(0, "@event",                               { link = "Identifier" })
    hi(0, "@exception",                           { link = "TSException" })
    hi(0, "@field",                               { link = "TSField" })
    hi(0, "@float",                               { link = "TSFloat" })
    hi(0, "@function",                            { link = "TSFunction" })
    hi(0, "@function.builtin",                    { link = "TSFuncBuiltin" })
    hi(0, "@function.call",                       { link = "TSFunctionCall" })
    hi(0, "@function.macro",                      { link = "TSFuncMacro" })
    hi(0, "@include",                             { link = "TSInclude" })
    hi(0, "@interface",                           { link = "Structure" })
    hi(0, "@keyword",                             { link = "TSKeyword" })
    hi(0, "@keyword.function",                    { link = "TSKeywordFunction" })
    hi(0, "@keyword.operator",                    { link = "TSKeywordOperator" })
    hi(0, "@keyword.return",                      { link = "TSKeyword" })
    hi(0, "@label",                               { link = "TSLabel" })
    hi(0, "@method",                              { link = "TSMethod" })
    hi(0, "@method.call",                         { link = "TSMethodCall" })
    hi(0, "@modifier",                            { link = "TSKeyword" })
    hi(0, "@namespace",                           { link = "TSNamespace" })
    hi(0, "@none",                                { link = "TSNone" })
    hi(0, "@number",                              { link = "TSNumber" })
    hi(0, "@operator",                            { link = "TSOperator" })
    hi(0, "@parameter",                           { link = "TSParameter" })
    hi(0, "@property",                            { link = "TSField" })
    hi(0, "@punctuation.bracket",                 { link = "TSPunctBracket" })
    hi(0, "@punctuation.delimiter",               { link = "TSPunctDelimiter" })
    hi(0, "@punctuation.special",                 { link = "TSPunctSpecial" })
    hi(0, "@regexp",                              { link = "TSStringRegex" })
    hi(0, "@repeat",                              { link = "TSRepeat" })
    hi(0, "@string",                              { link = "TSString" })
    hi(0, "@string.escape",                       { link = "TSStringEscape" })
    hi(0, "@string.regex",                        { link = "TSStringRegex" })
    hi(0, "@string.special",                      { link = "SpecialChar" })
    hi(0, "@struct",                              { link = "TSType" })
    hi(0, "@symbol",                              { link = "TSSymbol" })
    hi(0, "@tag",                                 { link = "TSTag" })
    hi(0, "@tag.attribute",                       { link = "TSAttribute" })
    hi(0, "@tag.delimiter",                       { link = "TSTagDelimiter" })
    hi(0, "@text",                                { link = "TSText" })
    hi(0, "@text.danger",                         { link = "DiagnosticError" })
    hi(0, "@text.emphasis",                       { link = "TSEmphasis" })
    hi(0, "@text.environment",                    { link = "Macro" })
    hi(0, "@text.environment.name",               { link = "Type" })
    hi(0, "@text.literal",                        { link = "TSLiteral" })
    hi(0, "@text.math",                           { link = "Number" })
    hi(0, "@text.note",                           { link = "Tag" })
    hi(0, "@text.reference",                      { link = "TSParameterReference" })
    hi(0, "@text.strike",                         { link = "TSStrike" })
    hi(0, "@text.strong",                         { link = "TSStrong" })
    hi(0, "@text.title",                          { link = "TSTitle" })
    hi(0, "@text.todo",                           { link = "Todo" })
    hi(0, "@text.underline",                      { link = "TSUnderline" })
    hi(0, "@text.uri",                            { link = "TSURI" })
    hi(0, "@text.warning",                        { link = "DiagnosticWarn" })
    hi(0, "@type",                                { link = "TSType" })
    hi(0, "@type.builtin",                        { link = "TSTypeBuiltin" })
    hi(0, "@type.definition",                     { link = "TSTypeDefinition" })
    hi(0, "@type.qualifier",                      { link = "TSType" })
    hi(0, "@typeParameter",                       { link = "Type" })
    hi(0, "@variable",                            { link = "TSVariable" })
    hi(0, "@variable.builtin",                    { link = "TSVariableBuiltin" })
    hi(0, "@lsp.type.namespace",                  { link = "TSNamespace" })
    hi(0, "@lsp.type.variable",                   { link = "TSVariable" })
    hi(0, "@lsp.type.parameter",                  { link = "TSVariable" })
    hi(0, "@lsp.typemod.variable.readonly",       { link = "TSConstant" })
    hi(0, "@lsp.type.type",                       { link = "TSType" })
    hi(0, "@lsp.type.function",                   {})
    hi(0, "@lsp.type.method",                     {})
    hi(0, "@lsp.type.comment",                    {})
    hi(0, "@lsp.typemod.variable.defaultLibrary", { link = "TSVariableBuiltin" })
    hi(0, "@lsp.mod.defaultLibrary.go",           { link = "TSVariableBuiltin" })
    hi(0, "@lsp.type.property",                   { link = "TSField" })
    hi(0, "@tag.attribute.tsx",                   { link = "TSParameter" })
    hi(0, "@tag.attribute.javascript",            { link = "TSParameter" })
  end

  -- ── Base UI ───────────────────────────────────────────────────────────────
  hi(0, "Normal",       { bg = color.background, fg = color.foreground })
  hi(0, "NormalFloat",  { bg = color.dark,        fg = color.foreground })
  hi(0, "NormalNC",     { bg = color.background,  fg = color.foreground })

  hi(0, "Bold",         { bold = true })
  hi(0, "Italic",       { italic = true })

  hi(0, "Cursor",       { bg = color.light_gray,  fg = color.background })
  hi(0, "TermCursor",   { bg = color.light_gray,  fg = color.background })
  hi(0, "TermCursorNC", { bg = color.comment,     fg = color.background })
  hi(0, "iCursor",      { bg = color.teal,        fg = color.background })
  hi(0, "lCursor",      { bg = color.light_gray,  fg = color.background })

  hi(0, "CursorLine",   { bg = color.cursor_line })
  hi(0, "CursorColumn", { bg = color.cursor_line })
  hi(0, "CursorLineNr", { bg = color.cursor_line, fg = color.light_gray, bold = true })
  hi(0, "LineNr",       { fg = color.comment })
  hi(0, "SignColumn",   { fg = color.comment })
  hi(0, "FoldColumn",   { fg = color.comment })
  hi(0, "Folded",       { bg = color.selection,   fg = color.light_gray })

  hi(0, "ColorColumn",  { bg = color.cursor_line })
  hi(0, "VertSplit",    { fg = color.medium_gray })
  hi(0, "WinSeparator", { fg = color.medium_gray })

  hi(0, "StatusLine",   { bg = color.selection,   fg = color.foreground })
  hi(0, "StatusLineNC", { bg = color.medium_gray, fg = color.light_gray })

  hi(0, "TabLine",      { bg = color.inactive_bg, fg = color.comment })
  hi(0, "TabLineFill",  { bg = color.inactive_bg })
  hi(0, "TabLineSel",   { bg = color.selection,   fg = color.foreground, bold = true })

  hi(0, "WinBar",       { fg = color.foreground })
  hi(0, "WinBarNC",     { fg = color.light_gray })

  hi(0, "Visual",       { bg = color.selection })
  hi(0, "VisualNOS",    { fg = color.red })

  -- default uses reversed/highlighted search — keep that boldness
  hi(0, "Search",       { bg = color.yellow,       fg = color.background, bold = true })
  hi(0, "IncSearch",    { bg = color.light_yellow, fg = color.background, bold = true })
  hi(0, "Substitute",   { bg = color.yellow,       fg = color.background })

  hi(0, "Pmenu",        { bg = color.dark,        fg = color.foreground })
  hi(0, "PmenuSel",     { bg = color.selection,   fg = color.foreground })
  hi(0, "PmenuSbar",    { bg = color.medium_gray })
  hi(0, "PmenuThumb",   { bg = color.light_gray })

  hi(0, "FloatBorder",  { fg = color.comment })
  hi(0, "MatchParen",   { fg = color.light_teal, bold = true })

  hi(0, "NonText",      { fg = color.medium_gray })
  hi(0, "SpecialKey",   { fg = color.comment })
  hi(0, "Whitespace",   { fg = color.medium_gray })

  hi(0, "Directory",    { fg = color.teal, bold = true })
  hi(0, "Title",        { fg = color.teal, bold = true })

  hi(0, "ErrorMsg",     { fg = color.red })
  hi(0, "WarningMsg",   { fg = color.yellow })
  hi(0, "ModeMsg",      { fg = color.light_green, bold = true })
  hi(0, "MoreMsg",      { fg = color.light_green, bold = true })
  hi(0, "Question",     { fg = color.light_green, bold = true })

  hi(0, "QuickFixLine", { bg = color.cursor_line })
  hi(0, "WildMenu",     { bg = color.yellow,      fg = color.background })

  hi(0, "IndentBlanklineChar",         { fg = color.medium_gray, nocombine = true })
  hi(0, "IndentBlanklineContextChar",  { fg = color.comment,     nocombine = true })
  hi(0, "IndentBlanklineContextStart", { sp = color.teal,        underline = true })
  hi(0, "IndentBlanklineSpaceChar",    { fg = color.medium_gray, nocombine = true })

  hi(0, "TreesitterContext", { bg = color.cursor_line, italic = true })

  -- ── Syntax — default color philosophy, xcodedark hex values ──────────────
  --   Comment  → teal-gray  (default: Cyan)
  hi(0, "Comment",     { fg = color.comment, italic = true })
  --   Constant → purple     (default: Magenta)
  hi(0, "Constant",    { fg = color.purple })
  --   String   → purple     (default: Magenta — strings = constants in default)
  hi(0, "String",      { fg = color.purple })
  hi(0, "Character",   { fg = color.purple })
  --   Number   → light-yellow (default: Magenta, we keep xcode numeric color)
  hi(0, "Number",      { fg = color.light_yellow })
  hi(0, "Boolean",     { fg = color.purple })
  hi(0, "Float",       { fg = color.light_yellow })
  --   Identifier/Function → teal/cyan (default: Cyan)
  hi(0, "Identifier",  { fg = color.teal })
  hi(0, "Function",    { fg = color.teal })
  --   Statement/Keyword → yellow bold (default: Yellow bold)
  hi(0, "Statement",   { fg = color.yellow, bold = true })
  hi(0, "Conditional", { fg = color.yellow, bold = true })
  hi(0, "Repeat",      { fg = color.yellow, bold = true })
  hi(0, "Label",       { fg = color.yellow, bold = true })
  hi(0, "Operator",    { fg = color.light_gray })
  hi(0, "Keyword",     { fg = color.yellow, bold = true })
  hi(0, "Exception",   { fg = color.yellow, bold = true })
  --   PreProc → pink/magenta (default: Magenta bright)
  hi(0, "PreProc",     { fg = color.pink })
  hi(0, "Include",     { fg = color.pink })
  hi(0, "Define",      { fg = color.pink })
  hi(0, "Macro",       { fg = color.pink })
  --   Type → green bold (default: Green bold)
  hi(0, "Type",        { fg = color.green, bold = true })
  hi(0, "StorageClass",{ fg = color.yellow, bold = true })
  hi(0, "Structure",   { fg = color.green, bold = true })
  hi(0, "Typedef",     { fg = color.green, bold = true })
  --   Special → light-blue/DarkCyan (default: DarkCyan)
  hi(0, "Special",     { fg = color.light_blue })
  hi(0, "SpecialChar", { fg = color.light_teal })
  hi(0, "Delimiter",   { fg = color.light_gray })
  hi(0, "Debug",       { fg = color.red })
  hi(0, "Error",       { bg = color.red, fg = color.background, bold = true })
  hi(0, "Todo",        { bg = color.selection, fg = color.yellow, bold = true })
  hi(0, "Underlined",  { fg = color.teal, underline = true })
  hi(0, "Ignore",      { fg = color.dark })
  hi(0, "Tag",         { fg = color.light_yellow })

  -- ── Treesitter — respects default's bold/italic conventions ──────────────
  hi(0, "TSAnnotation",     { fg = color.pink })
  hi(0, "TSAttribute",      { fg = color.pink })
  hi(0, "TSBoolean",        { fg = color.purple })
  hi(0, "TSCharacter",      { fg = color.purple })
  hi(0, "TSComment",        { fg = color.comment, italic = true })
  hi(0, "TSConditional",    { fg = color.yellow,  bold = true })
  hi(0, "TSConstant",       { fg = color.purple })
  hi(0, "TSConstBuiltin",   { fg = color.purple,  italic = true })
  hi(0, "TSConstantBuiltin",{ fg = color.purple,  italic = true })
  hi(0, "TSConstMacro",     { fg = color.pink })
  hi(0, "TSConstructor",    { fg = color.light_blue })
  hi(0, "TSCurrentScope",   { bold = true })
  hi(0, "TSDefinition",     { sp = color.light_gray, underline = true })
  hi(0, "TSDefinitionUsage",{ sp = color.light_gray, underline = true })
  hi(0, "TSEmphasis",       { fg = color.yellow, italic = true })
  hi(0, "TSError",          { fg = color.red })
  hi(0, "TSException",      { fg = color.yellow, bold = true })
  hi(0, "TSField",          { fg = color.foreground })
  hi(0, "TSFloat",          { fg = color.light_yellow })
  hi(0, "TSFuncBuiltin",    { fg = color.light_teal, bold = true })
  hi(0, "TSFuncMacro",      { fg = color.pink })
  hi(0, "TSFunction",       { fg = color.teal, bold = true })   -- bold like default Function
  hi(0, "TSFunctionCall",   { fg = color.teal })
  hi(0, "TSMethodCall",     { fg = color.teal })
  hi(0, "TSInclude",        { fg = color.pink })
  hi(0, "TSKeyword",        { fg = color.yellow,  bold = true })
  hi(0, "TSKeywordFunction",{ fg = color.yellow,  bold = true })
  hi(0, "TSKeywordOperator",{ fg = color.yellow,  bold = true })
  hi(0, "TSLabel",          { fg = color.yellow,  bold = true })
  hi(0, "TSLiteral",        { fg = color.purple })
  hi(0, "TSMethod",         { fg = color.teal,    bold = true })
  hi(0, "TSNamespace",      { fg = color.light_teal })
  hi(0, "TSNone",           { fg = color.foreground })
  hi(0, "TSNumber",         { fg = color.light_yellow })
  hi(0, "TSOperator",       { fg = color.light_gray })
  hi(0, "TSParameter",      { fg = color.foreground })
  hi(0, "TSParameterReference",{ fg = color.foreground })
  hi(0, "TSProperty",       { fg = color.foreground })
  hi(0, "TSPunctBracket",   { fg = color.light_gray })
  hi(0, "TSPunctDelimiter", { fg = color.light_gray })
  hi(0, "TSPunctSpecial",   { fg = color.light_teal })
  hi(0, "TSRepeat",         { fg = color.yellow,  bold = true })
  hi(0, "TSString",         { fg = color.purple })              -- strings=magenta in default
  hi(0, "TSStringEscape",   { fg = color.light_teal })
  hi(0, "TSStringRegex",    { fg = color.light_teal })
  hi(0, "TSStrong",         { bold = true })
  hi(0, "TSStrike",         { fg = color.dark, strikethrough = true })
  hi(0, "TSSymbol",         { fg = color.light_green })
  hi(0, "TSTag",            { fg = color.yellow,  bold = true })
  hi(0, "TSTagDelimiter",   { fg = color.light_gray })
  hi(0, "TSText",           { fg = color.foreground })
  hi(0, "TSTitle",          { fg = color.teal, bold = true })
  hi(0, "TSType",           { fg = color.green,   bold = true })
  hi(0, "TSTypeBuiltin",    { fg = color.green,   bold = true, italic = true })
  hi(0, "TSTypeDefinition", { fg = color.green,   bold = true })
  hi(0, "TSURI",            { fg = color.teal, underline = true })
  hi(0, "TSUnderline",      { underline = true })
  hi(0, "TSVariable",       { fg = color.foreground })
  hi(0, "TSVariableBuiltin",{ fg = color.light_teal, italic = true })

  -- ── Statement / Identifier overrides ─────────────────────────────────────
  hi(0, "Statement",  { link = "TSKeyword" })
  hi(0, "Comment",    { link = "TSComment" })
  hi(0, "Number",     { link = "TSNumber" })
  hi(0, "String",     { link = "TSString" })
  hi(0, "Identifier", { link = "TSVariable" })

  hi(0, "@lsp.type.keyword.go",             { link = "TSKeyword" })
  hi(0, "@lsp.type.string.go",              { link = "TSString" })
  hi(0, "@lsp.type.function",               { link = "TSFunctionCall" })
  hi(0, "@lsp.typemod.function.definition", { link = "TSFunction" })
  hi(0, "@lsp.type.method",                 { link = "TSMethod" })
  hi(0, "goBlock",                          { link = "TSVariable" })
  hi(0, "goImportString",                   { link = "TSString" })

  -- ── Diagnostics ───────────────────────────────────────────────────────────
  hi(0, "DiagnosticError",               { fg = color.red })
  hi(0, "DiagnosticWarn",                { fg = color.yellow })
  hi(0, "DiagnosticInfo",                { fg = color.teal })
  hi(0, "DiagnosticHint",                { fg = color.light_teal })
  hi(0, "DiagnosticUnderlineError",      { sp = color.red,        undercurl = true })
  hi(0, "DiagnosticUnderlineWarn",       { sp = color.yellow,     undercurl = true })
  hi(0, "DiagnosticUnderlineInformation",{ sp = color.teal,       undercurl = true })
  hi(0, "DiagnosticUnderlineHint",       { sp = color.light_teal, undercurl = true })
  hi(0, "DiagnosticUnderlineWarning",    { sp = color.yellow,     undercurl = true })
  hi(0, "LspDiagnosticsDefaultError",        { link = "DiagnosticError" })
  hi(0, "LspDiagnosticsDefaultHint",         { link = "DiagnosticHint" })
  hi(0, "LspDiagnosticsDefaultInformation",  { link = "DiagnosticInfo" })
  hi(0, "LspDiagnosticsDefaultWarning",      { link = "DiagnosticWarn" })
  hi(0, "LspDiagnosticsUnderlineError",      { link = "DiagnosticUnderlineError" })
  hi(0, "LspDiagnosticsUnderlineHint",       { link = "DiagnosticUnderlineHint" })
  hi(0, "LspDiagnosticsUnderlineInformation",{ link = "DiagnosticUnderlineInformation" })
  hi(0, "LspDiagnosticsUnderlineWarning",    { link = "DiagnosticUnderlineWarning" })
  hi(0, "LspReferenceRead",  { sp = color.light_gray, underline = true })
  hi(0, "LspReferenceText",  { sp = color.light_gray, underline = true })
  hi(0, "LspReferenceWrite", { sp = color.light_gray, underline = true })

  -- ── nvim-cmp ──────────────────────────────────────────────────────────────
  if M.config.opt.integrations.nvim_cmp then
    hi(0, "CmpDocumentation",        { fg = color.foreground })
    hi(0, "CmpDocumentationBorder",  { fg = color.comment })
    hi(0, "CmpItemAbbr",             { fg = color.foreground })
    hi(0, "CmpItemAbbrDeprecated",   { fg = color.comment, strikethrough = true })
    hi(0, "CmpItemAbbrMatch",        { fg = color.teal,    bold = true })
    hi(0, "CmpItemAbbrMatchFuzzy",   { fg = color.teal })
    hi(0, "CmpItemKindDefault",      { fg = color.teal })
    hi(0, "CmpItemKindClass",        { fg = color.green,   bold = true })
    hi(0, "CmpItemKindConstant",     { fg = color.purple })
    hi(0, "CmpItemKindConstructor",  { fg = color.light_blue })
    hi(0, "CmpItemKindEnum",         { fg = color.green,   bold = true })
    hi(0, "CmpItemKindEnumMember",   { fg = color.light_purple })
    hi(0, "CmpItemKindEvent",        { fg = color.green })
    hi(0, "CmpItemKindField",        { fg = color.foreground })
    hi(0, "CmpItemKindFunction",     { fg = color.teal,    bold = true })
    hi(0, "CmpItemKindInterface",    { fg = color.green })
    hi(0, "CmpItemKindKeyword",      { fg = color.yellow,  bold = true })
    hi(0, "CmpItemKindMethod",       { fg = color.teal,    bold = true })
    hi(0, "CmpItemKindModule",       { fg = color.foreground })
    hi(0, "CmpItemKindOperator",     { fg = color.light_gray })
    hi(0, "CmpItemKindProperty",     { fg = color.foreground })
    hi(0, "CmpItemKindReference",    { fg = color.foreground })
    hi(0, "CmpItemKindSnippet",      { fg = color.light_gray })
    hi(0, "CmpItemKindStruct",       { fg = color.green,   bold = true })
    hi(0, "CmpItemKindTypeParameter",{ fg = color.light_purple })
    hi(0, "CmpItemKindUnit",         { fg = color.light_yellow })
    hi(0, "CmpItemKindValue",        { fg = color.purple })
    hi(0, "CmpItemKindVariable",     { fg = color.foreground })
    hi(0, "CmpItemMenu",             { fg = color.comment })
  end

  -- ── DAP ───────────────────────────────────────────────────────────────────
  if M.config.opt.integrations.dap_nvim then
    hi(0, "DapUIBreakpointsCurrentLine", { bold = true, fg = color.light_green })
    hi(0, "DapUIBreakpointsDisabledLine",{ fg = color.comment })
    hi(0, "DapUIBreakpointsInfo",        { fg = color.light_green })
    hi(0, "DapUIBreakpointsPath",        { fg = color.light_teal })
    hi(0, "DapUIDecoration",             { fg = color.light_teal })
    hi(0, "DapUIFloatBorder",            { fg = color.light_teal })
    hi(0, "DapUILineNumber",             { fg = color.light_teal })
    hi(0, "DapUIModifiedValue",          { bold = true, fg = color.light_teal })
    hi(0, "DapUIPlayPause",              { fg = color.light_green })
    hi(0, "DapUIPlayPauseNC",            { fg = color.light_green })
    hi(0, "DapUIRestart",                { fg = color.light_green })
    hi(0, "DapUIRestartNC",              { fg = color.light_green })
    hi(0, "DapUIScope",                  { fg = color.teal })
    hi(0, "DapUISource",                 { fg = color.light_purple })
    hi(0, "DapUIStepBack",               { fg = color.teal })
    hi(0, "DapUIStepBackNC",             { fg = color.teal })
    hi(0, "DapUIStepInto",               { fg = color.teal })
    hi(0, "DapUIStepIntoNC",             { fg = color.teal })
    hi(0, "DapUIStepOut",                { fg = color.teal })
    hi(0, "DapUIStepOutNC",              { fg = color.teal })
    hi(0, "DapUIStepOver",               { fg = color.teal })
    hi(0, "DapUIStepOverNC",             { fg = color.teal })
    hi(0, "DapUIStop",                   { fg = color.red })
    hi(0, "DapUIStopNC",                 { fg = color.red })
    hi(0, "DapUIStoppedThread",          { fg = color.light_teal })
    hi(0, "DapUIThread",                 { fg = color.light_green })
    hi(0, "DapUIType",                   { fg = color.light_purple })
    hi(0, "DapUIUnavailable",            { fg = color.comment })
    hi(0, "DapUIUnavailableNC",          { fg = color.comment })
    hi(0, "DapUIWatchesEmpty",           { fg = color.red })
    hi(0, "DapUIWatchesError",           { fg = color.red })
    hi(0, "DapUIWatchesValue",           { fg = color.light_green })
  end

  -- ── Git ───────────────────────────────────────────────────────────────────
  hi(0, "GitGutterAdd",          { fg = color.green })
  hi(0, "GitGutterChange",       { fg = color.teal })
  hi(0, "GitGutterChangeDelete", { fg = color.yellow })
  hi(0, "GitGutterDelete",       { fg = color.red })

  hi(0, "GitSignsCurrentLineBlame", { fg = color.comment, italic = true })
  hi(0, "GitSignsStagedAdd",        { fg = color.light_green })
  hi(0, "GitSignsStagedChange",     { fg = color.teal })
  hi(0, "GitSignsStagedDelete",     { fg = color.red })

  hi(0, "gitcommitBranch",        { bold = true, fg = color.yellow })
  hi(0, "gitcommitComment",       { fg = color.comment })
  hi(0, "gitcommitDiscarded",     { fg = color.comment })
  hi(0, "gitcommitDiscardedFile", { bold = true, fg = color.red })
  hi(0, "gitcommitDiscardedType", { fg = color.teal })
  hi(0, "gitcommitHeader",        { fg = color.yellow, bold = true })
  hi(0, "gitcommitOverflow",      { fg = color.red })
  hi(0, "gitcommitSelected",      { fg = color.comment })
  hi(0, "gitcommitSelectedFile",  { bold = true, fg = color.light_green })
  hi(0, "gitcommitSelectedType",  { fg = color.teal })
  hi(0, "gitcommitSummary",       { fg = color.light_green })
  hi(0, "gitcommitUnmergedFile",  { bold = true, fg = color.red })
  hi(0, "gitcommitUnmergedType",  { fg = color.teal })
  hi(0, "gitcommitUntracked",     { fg = color.comment })
  hi(0, "gitcommitUntrackedFile", { fg = color.light_yellow })

  -- ── Notify ────────────────────────────────────────────────────────────────
  hi(0, "NotifyDEBUGBody",   { link = "Normal" })
  hi(0, "NotifyDEBUGBorder", { fg = color.comment })
  hi(0, "NotifyDEBUGIcon",   { fg = color.comment })
  hi(0, "NotifyDEBUGTitle",  { fg = color.comment })
  hi(0, "NotifyERRORBody",   { link = "Normal" })
  hi(0, "NotifyERRORBorder", { fg = color.red })
  hi(0, "NotifyERRORIcon",   { fg = color.red })
  hi(0, "NotifyERRORTitle",  { fg = color.red })
  hi(0, "NotifyINFOBody",    { link = "Normal" })
  hi(0, "NotifyINFOBorder",  { fg = color.light_gray })
  hi(0, "NotifyINFOIcon",    { fg = color.light_gray })
  hi(0, "NotifyINFOTitle",   { fg = color.light_gray })
  hi(0, "NotifyTRACEBody",   { link = "Normal" })
  hi(0, "NotifyTRACEBorder", { fg = color.purple })
  hi(0, "NotifyTRACEIcon",   { fg = color.purple })
  hi(0, "NotifyTRACETitle",  { fg = color.purple })
  hi(0, "NotifyWARNBody",    { link = "Normal" })
  hi(0, "NotifyWARNBorder",  { fg = color.yellow })
  hi(0, "NotifyWARNIcon",    { fg = color.yellow })
  hi(0, "NotifyWARNTitle",   { fg = color.yellow })

  -- ── Telescope ─────────────────────────────────────────────────────────────
  if M.config.opt.integrations.telescope then
    hi(0, "TelescopeBorder",        { bg = color.dark,        fg = color.dark })
    hi(0, "TelescopeNormal",        { bg = color.dark })
    hi(0, "TelescopePreviewLine",   { bg = color.cursor_line })
    hi(0, "TelescopePreviewTitle",  { bg = color.light_green, fg = color.background })
    hi(0, "TelescopePromptBorder",  { bg = color.medium_gray, fg = color.medium_gray })
    hi(0, "TelescopePromptNormal",  { bg = color.medium_gray, fg = color.foreground })
    hi(0, "TelescopePromptPrefix",  { bg = color.medium_gray, fg = color.red })
    hi(0, "TelescopePromptTitle",   { bg = color.red,         fg = color.background })
    hi(0, "TelescopeResultsTitle",  { bg = color.dark,        fg = color.dark })
    hi(0, "TelescopeSelection",     { bg = color.medium_gray })
  end

  -- ── Snacks Dashboard ──────────────────────────────────────────────────────
  hi(0, "SnacksDashboardHeader",   { fg = color.yellow,     bold = true })
  hi(0, "SnacksDashboardTitle",    { fg = color.yellow,     bold = true })
  hi(0, "SnacksDashboardIcon",     { fg = color.teal })
  hi(0, "SnacksDashboardDesc",     { fg = color.light_gray })
  hi(0, "SnacksDashboardFile",     { fg = color.light_teal, bold = true })
  hi(0, "SnacksDashboardKey",      { fg = color.yellow,     bold = true })
  hi(0, "SnacksDashboardSpecial",  { fg = color.light_gray })
  hi(0, "SnacksDashboardDir",      { fg = color.light_gray })
  hi(0, "SnacksDashboardNormal",   { fg = color.light_gray })
  hi(0, "SnacksDashboardTerminal", { fg = color.light_gray })
  hi(0, "SnacksDashboardFooter",   { fg = color.comment })

  -- ── Neo-Tree ──────────────────────────────────────────────────────────────
  hi(0, "NeoTreeFileName",             { fg = color.foreground })
  hi(0, "NeoTreeDotfile",              { fg = color.comment })
  hi(0, "NeoTreeDirectoryName",        { fg = color.yellow,    bold = true })
  hi(0, "NeoTreeDirectoryIcon",        { fg = color.yellow })
  hi(0, "NeoTreeGitModified",          { fg = color.yellow })
  hi(0, "NeoTreeGitStaged",            { fg = color.green })
  hi(0, "NeoTreeGitUntracked",         { fg = color.purple })
  hi(0, "NeoTreeNormal",               { fg = color.foreground, bg = color.dark })
  hi(0, "NeoTreeNormalNC",             { fg = color.foreground, bg = color.dark })
  hi(0, "NeoTreeTabActive",            { fg = color.foreground, bg = color.dark, bold = true })
  hi(0, "NeoTreeTabInactive",          { fg = color.comment,    bg = color.dark })
  hi(0, "NeoTreeTabSeparatorActive",   { fg = color.foreground, bg = color.dark })
  hi(0, "NeoTreeTabSeparatorInactive", { fg = color.comment,    bg = color.dark })

  -- ── Copilot ───────────────────────────────────────────────────────────────
  hi(0, "CopilotSuggestion", { fg = color.comment })

  -- ── Spell ─────────────────────────────────────────────────────────────────
  hi(0, "SpellBad",   { sp = color.red,    undercurl = true })
  hi(0, "SpellCap",   { sp = color.teal,   undercurl = true })
  hi(0, "SpellLocal", { sp = color.green,  undercurl = true })
  hi(0, "SpellRare",  { sp = color.yellow, undercurl = true })

  -- ── nvim-ts-rainbow ───────────────────────────────────────────────────────
  hi(0, "rainbowcol1", { fg = color.foreground })
  hi(0, "rainbowcol2", { fg = color.yellow })
  hi(0, "rainbowcol3", { fg = color.green })
  hi(0, "rainbowcol4", { fg = color.light_purple })
  hi(0, "rainbowcol5", { fg = color.teal })
  hi(0, "rainbowcol6", { fg = color.pink })
  hi(0, "rainbowcol7", { fg = color.light_teal })

  -- ── User / StatusLine accents ─────────────────────────────────────────────
  hi(0, "User1", { bg = color.selection, fg = color.red })
  hi(0, "User2", { bg = color.selection, fg = color.yellow })
  hi(0, "User3", { bg = color.selection, fg = color.foreground })
  hi(0, "User4", { bg = color.selection, fg = color.teal })
  hi(0, "User5", { bg = color.selection, fg = color.light_gray })
  hi(0, "User6", { bg = color.dark,      fg = color.light_gray })
  hi(0, "User7", { bg = color.selection, fg = color.light_gray })
  hi(0, "User8", { bg = color.selection, fg = color.background })
  hi(0, "User9", { bg = color.selection, fg = color.background })

  -- ── Terminal colors ───────────────────────────────────────────────────────
  local g = vim.g
  g.terminal_color_0  = color.background
  g.terminal_color_1  = color.red
  g.terminal_color_2  = color.green
  g.terminal_color_3  = color.yellow
  g.terminal_color_4  = color.teal
  g.terminal_color_5  = color.purple
  g.terminal_color_6  = color.light_teal
  g.terminal_color_7  = color.light_gray
  g.terminal_color_8  = color.comment
  g.terminal_color_9  = color.pink
  g.terminal_color_10 = color.light_green
  g.terminal_color_11 = color.light_yellow
  g.terminal_color_12 = color.light_blue
  g.terminal_color_13 = color.light_purple
  g.terminal_color_14 = color.blue
  g.terminal_color_15 = color.foreground
end

return M
