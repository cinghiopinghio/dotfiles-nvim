local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("plugins.null.utils")

local COMPLETION = methods.internal.COMPLETION

-- a place to cache results
local contacts = nil

local function get_contacts()
    if contacts ~= nil then
        return contacts
    end
    local cmd = io.popen('notmuch address "*"')
    if cmd ~= nil then
        local data = cmd:read("*all")
        contacts = vim.fn.split(data, "\n")
        return contacts
    end
    return nil
end

return h.make_builtin({
    method = COMPLETION,
    filetypes = { "mail" },
    name = "notmuch",
    generator = {
        fn = function(params, done)
            if not utils.is_in_header(params.content[params.row]) then
                done({ { items = {}, isIncomplete = false } })
                return
            end

            -- Tags look up can be expensive.
            if #params.word_to_complete < 4 then
                done({ { items = {}, isIncomplete = false } })
                return
            end
            print(vim.inspect(params))

            local get_candidates = function(_)
                local items = {}
                for k, v in ipairs(get_contacts()) do
                    items[k] = { label = v, kind = vim.lsp.protocol.CompletionItemKind["Text"] }
                end

                return items
            end

            local candidates = get_candidates(vim.fn.spellsuggest(params.word_to_complete))
            done({ { items = candidates, isIncomplete = #candidates } })
        end,
        async = true,
    },
})
