-- disable built-in plugins which I don't use to improve startup time
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    -- "gzip",
    "logipat",
    "man",
    "matchit",
    "netrw",
    "netrwFileHandlers",
    "netrwPlugin",
    "netrwSettings",
    "rrhelper",
    "spellfile_plugin",
    "tar",
    "tarPlugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
