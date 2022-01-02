-- https://gist.github.com/hoob3rt/b200435a765ca18f09f83580a606b878
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")
local mode = require("lualine.utils.mode")

local function gethighlight(hlGroupName, key)
    key = key or "foreground"
    local hlGroup = vim.api.nvim_get_hl_by_name(hlGroupName, true)
    if hlGroup[key] then
        -- The color exists, return its HEX form
        return string.format("#%x", hlGroup[key])
    end

    return "None"
end

-- Color table for highlights
local colors = {
    bg = gethighlight("Statusline", "background"),
    fg = gethighlight("Statusline"),
    red = gethighlight("Error"),
    yellow = gethighlight("Warning"),
    cyan = gethighlight("SpellRare"),
    green = gethighlight("DiffAdd"),
    orange = gethighlight("DiffText"),
    purple = gethighlight("Search"),
    magenta = gethighlight("Search"),
    blue = gethighlight("VisualMode"),
}

local symbols = {
    space = " ",
    plus = " ",
    minus = " ",
    left = "",
    right = "",
    block = "█",
    ball = "●",
    error = " ",
    warn = " ",
    info = " ",
    ltab = "█",
    rtab = "█",
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local function tabline()
    local s = ""

    local sepfg = gethighlight("TabLineSel", "background")
    local sepbg = gethighlight("TabLine", "background")
    vim.cmd("hi TabLineSelSep guifg=" .. sepfg .. " guibg=" .. sepbg)

    for index = 1, vim.fn.tabpagenr("$") do
        local winnr = vim.fn.tabpagewinnr(index) -- number of current window
        local buflist = vim.fn.tabpagebuflist(index) -- list of buffers displayed in tab
        local bufnr = buflist[winnr] -- buf num in current win in tab
        local bufname = vim.fn.bufname(bufnr) -- name of buf
        local bufmodified = vim.fn.getbufvar(bufnr, "&mod") -- is modified?

        if index == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSelSep#" .. symbols.ltab .. "%#TabLineSel#"
        else
            s = s .. "%#TabLine# "
        end

        -- s = s .. index .. ':'

        if bufname ~= "" then
            s = s .. vim.fn.fnamemodify(bufname, ":t")
        else
            s = s .. "[NONAME]"
        end

        if bufmodified == 1 then
            s = s .. " " .. symbols.ball
        end

        if index == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSelSep#" .. symbols.rtab
        end

        if index ~= vim.fn.tabpagenr("$") then
            s = s .. " "
        else
            s = s .. " %#TabLineFill#"
        end
    end

    return s
end

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = "",
        theme = {
            -- We are going to use lualine_c an lualine_x as left and
            -- right section. Both are highlighted by c theme .  So we
            -- are just setting default looks o statusline
            -- normal = {c = {fg = colors.fg, bg = colors.bg}},
            normal = {
                a = "Statusline",
                b = "Statusline",
                c = "StatusLine",
            },
            inactive = { c = "StatusLineNC" },
        },
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "fzf",
    },
    tabline = {
        lualine_c = {
            {
                function()
                    return "%="
                end,
            }, -- this get the tabs horizontally centered
            { tabline },
            -- {
            --     function()
            --         return "%="
            --     end,
            -- }, -- this get the tabs horizontally centered
        },
    },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component, section)
    section = config.sections[section] or config.sections.lualine_c
    table.insert(section, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component, section)
    section = config.sections[section] or config.sections.lualine_x
    table.insert(section, component)
end

config.inactive_sections.lualine_c = {
    {
        function()
            return symbols.block
        end,
        padding = { left = 0 }, -- We don't need space before this
    },
    {
        "filename",
        cond = conditions.buffer_not_empty,
    },
}

config.inactive_sections.lualine_x = {
    {
        function()
            return symbols.block
        end,
        padding = 0, -- We don't need space before this
    },
}

ins_left({
    -- mode component
    function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.purple,
            i = colors.yellow,
            v = colors.green,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.cyan,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.purple,
            Rv = colors.purple,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
        }
        vim.api.nvim_command("hi! LualineMode guibg=" .. mode_color[vim.fn.mode()] .. " guifg=" .. colors.bg)
        vim.api.nvim_command("hi! LualineModeInv guifg=" .. mode_color[vim.fn.mode()] .. " guibg=None" .. colors.fg)
        -- return string.upper(vim.api.nvim_get_mode().mode)
        return mode.get_mode():sub(1, 1)
    end,
    color = "LualineMode", -- Sets highlighting of component
    padding = { left = 1, right = 0 },
}, "lualine_a")

ins_left({
    function()
        return symbols.right
    end,
    color = "LualineModeInv", -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
}, "lualine_a")

ins_left({
    "location",
    cond = conditions.buffer_not_empty,
    padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
    "progress",
    cond = conditions.buffer_not_empty,
    color = { gui = "bold" },
    padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
    function()
        return symbols.left
    end,
    color = { fg = colors.magenta }, -- Sets highlighting of component
    cond = conditions.buffer_not_empty,
    padding = { left = 0, right = 0 }, -- We don't need space before this
})
ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { bg = colors.magenta, gui = "bold" },
    symbols = {
        modified = " " .. symbols.ball,

        readonly = symbols.minus,
    },
    padding = 0, -- We don't need space before this
})
ins_left({
    function()
        return symbols.right
    end,
    color = { fg = colors.magenta }, -- Sets highlighting of component
    cond = conditions.buffer_not_empty,
    padding = 0, -- We don't need space before this
})

ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = symbols.error, warn = symbols.warn, info = symbols.info },
    diagnostics_color = {
        error = { fg = colors.red },
        warning = { fg = colors.yellow },
        info = { fg = colors.cyan },
        hint = { fg = colors.cyan },
    },
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
    function()
        return "%="
    end,
})

ins_left({
    -- Lsp server name .
    function()
        local msg = {}
        for _, client in pairs(vim.lsp.buf_get_clients(0)) do
            table.insert(msg, client.name)
        end
        return table.concat(msg, "|")
    end,
    icon = "LS:",
})

-- Add components to right sections
ins_right({
    "filetype",
    padding = 1,
    fmt = string.upper,
    icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { bg = colors.yellow, gui = "bold" },
})

ins_right({
    "o:encoding", -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = "bold" },
})

ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    color = { fg = colors.green, gui = "bold" },
})

ins_right({
    "branch",
    icon = "",
    cond = conditions.check_git_workspace,
    color = { fg = colors.purple, gui = "bold" },
})

ins_right({
    "diff",
    -- Is it me or the symbol for modified us really weird
    symbols = { added = symbols.plus, modified = symbols.info, removed = symbols.minus },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})

ins_right({
    function()
        return symbols.space
    end,
    color = "LualineMode", -- Sets highlighting of component
    padding = { right = 0 },
}, "lualine_z")

-- Now don't forget to initialize lualine
lualine.setup(config)
