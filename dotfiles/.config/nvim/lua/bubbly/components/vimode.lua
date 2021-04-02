-- ===========
-- MODE BUBBLE
-- ===========
-- Created by datwaft <github.com/datwaft>
-- Modified by CinghioPinghio

local settings = {
    tag = vim.g.bubbly_tags.mode,
    color = vim.g.bubbly_colors.mode,
    inactive_color = vim.g.bubbly_inactive_color,
    style = vim.g.bubbly_styles.mode,
    inactive_style = vim.g.bubbly_inactive_style,
}

if vim.g.bubbly_characters then
    for _, char in ipairs({'pre', 'post', 'left', 'right'})
        do
            settings[char] = vim.g.bubbly_characters[char]
        end
end

if vim.g.bubbly_characters.vimode then
    for char, val in pairs(vim.g.bubbly_characters.vimode)
        do
            settings[char] = val
        end
end

if not settings.tag then
    require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load tag configuration for the component 'mode', the default tag will be used.]]
    settings.tag = vim.g.bubbly_tags.default
end
if not settings.color then
    require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load color configuration for the component 'mode', the default color will be used.]]
    settings.color = vim.g.bubbly_colors.default
end
if not settings.style then
    require'bubbly.utils.io'.warning[[[BUBBLY.NVIM] => [WARNING] Couldn't load style configuration for the component 'mode', the default style will be used.]]
    settings.style = vim.g.bubbly_styles.default
end

return function(inactive)
    if inactive then
        return {{ data='' }}
    end

    local mode = vim.fn.mode()
    local data
    local color
    local style

    if mode == 'n' then
        data = settings.tag.normal
        if not inactive then
            color = settings.color.normal
        end
    elseif mode == 'i' then
        data = settings.tag.insert
        if not inactive then
            color = settings.color.insert
        end
    elseif mode == 'v' or mode == 'V' then
        data = settings.tag.visual
        if not inactive then
            color = settings.color.visual
        end
    elseif mode == '^V' or mode == '' then
        data = settings.tag.visualblock
        if not inactive then
            color = settings.color.visualblock
        end
    elseif mode == 'c' then
        data = settings.tag.command
        if not inactive then
            color = settings.color.command
        end
    elseif mode == 't' then
        data = settings.tag.terminal
        if not inactive then
            color = settings.color.terminal
        end
    elseif mode == 'R' then
        data = settings.tag.replace
        if not inactive then
            color = settings.color.replace
        end
    else
        data = settings.tag.default
        if not inactive then
            color = settings.color.default
        end
    end
    return {{
        data = data,
        color = color,
        style = style,
        left = settings.left,
        right = settings.right,
        pre = settings.pre,
        post = settings.post
    }}
end
