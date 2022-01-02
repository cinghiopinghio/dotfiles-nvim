local g = vim.g
local cmd = vim.cmd

local function map(lhs, rhs, mode)
    mode = mode or "n"
    if mode == "n" then
        rhs = "<cmd>" .. rhs .. "<cr>"
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end
