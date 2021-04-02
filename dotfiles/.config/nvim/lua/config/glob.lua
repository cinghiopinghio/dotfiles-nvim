local g = vim.g
local cmd = vim.cmd

local function map(lhs, rhs, mode)
    mode = mode or 'n'
    if mode == 'n' then
        rhs = '<cmd>' .. rhs .. '<cr>'
    end
    vim.api.nvim_set_keymap(
        mode,
        lhs,
        rhs,
        {noremap=true, silent=true}
    )
end

-- UltiSnips
g.UltiSnipsExpandTrigger = "<c-k>"        -- Do not use <tab>
g.UltiSnipsJumpForwardTrigger = "<c-k>"   -- Do not use <c-j>

-- AutoPairs
cmd [[ let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'} ]]

-- cycle
g.cycle_no_mappings = 1    -- just set my keys
g.cycle_max_conflict = 1   -- do not handle conflicts (better performance)
map('<C-A>', '<plug>CycleNext')
map('<C-X>', '<plug>CyclePrev')
map('<plug>CycleFallbackNext', '<C-A>')
map('<plug>CycleFallbackPrev', '<C-X>')

g.cycle_default_groups = {
    {{'true', 'false'}},
    {{'yes', 'no'}},
    {{'on', 'off'}},
    {{'+', '-'}},
    {{'>', '<'}},
    {{'"', "'"}},
    {{'==', '!='}},
    {{'and', 'or'}},
    {{"in", "out"}},
    {{"up", "down"}},
    {{"min", "max"}},
    {{"get", "set"}},
    {{"add", "remove"}},
    {{"to", "from"}},
    {{"read", "write"}},
    {{'without', 'with'}},
    {{"exclude", "include"}},
    {{'{:}', '[:]', '(:)'}, 'sub_pairs'},
    {{'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'}, 'hard_case', {name='Days'}}
}

g.cycle_default_groups_for_tex = {
    {{'tiny', 'scriptsize', 'footnotesize', 'small', 'normalsize', 'large', 'Large', 'LARGE', 'huge', 'Huge'}, 'hard_case', 'match_case'},
    {{'displaystyle', 'scriptstyle', 'scriptscriptstyle', 'textstyle'}},
    {{'part', 'chapter', 'section', 'subsection', 'subsubsection', 'paragraph', 'subparagraph'}},
    {{'article', 'report', 'book', 'letter', 'slides'}},
    {{'scrbook', 'scrreprt', 'scrartcl', 'scrlttr2'}},
    {{'oneside', 'twoside'}},
    {{'onecolumn', 'twocolumn'}},
    {{'draft', 'final'}},
    {{'\big(:\big)', '\\Big(:\\Big)', '\bigg(:\bigg)', '\\Bigg(:\\Bigg)'}, 'sub_pairs', 'hard_case', 'match_case'},
    {{'\big[:\big]', '\\Big[:\\Big]', '\bigg[:\bigg]', '\\Bigg[:\\Bigg]'}, 'sub_pairs', 'hard_case', 'match_case'},
    {{'\big\\{:\big\\}', '\\Big\\{:\\Big\\}', '\bigg\\{:\bigg\\}', '\\Bigg\\{:\\Bigg\\}'}, 'sub_pairs', 'hard_case', 'match_case'},
    {{'\big\\l:\big\r', '\\Big\\l:\\Big\r', '\bigg\\l:\bigg\r', '\\Bigg\\l:\\Bigg\r'}, 'sub_pairs', 'hard_case', 'match_case'},
    {{'\big', '\\Big', '\bigg', '\\Bigg'}, 'hard_case', 'match_case'},
}

-- Floaterm
g.floaterm_keymap_toggle = '<F12>'
g.floaterm_winblend=20
g.floaterm_position='center'

-- indent_blankline
g.indent_blankline_filetype_exclude = {'tex', 'markdown', 'help', 'no ft'}
g.indent_blankline_buftype_exclude = {'terminal'}
g.indent_blankline_char_highlight = 'Comment'
g.indent_blankline_char = '▏'
g.indent_blankline_use_treesitter = false
g.indent_blankline_show_trailing_blankline_indent = false

-- Lion align
g.lion_squeeze_spaces=1
-- Start interactive EasyAlign in visual mode (e.g. vipga)
map('ga', '<plug>(EasyAlign)', 'x')
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('ga', '<plug>(EasyAlign)')

map('<m-left>', ':SidewaysLeft<cr>')
map('<m-right>', ':SidewaysRight<cr>')

map('<localleader>a', ':ArgWrap<CR>')

g.rooter_targets = '*'
g.rooter_patterns = {'.git', 'Makefile', 'README.md'}
g.rooter_change_directory_for_non_project_files = 'current'

g.jupytext_fmt = 'py'
