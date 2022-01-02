local h = require("null-ls.helpers")
local methods = require("null-ls.methods")
local utils = require("plugins.null.utils")

local COMPLETION = methods.internal.COMPLETION

local function get_contacts(url)
    local reply = require("plenary.curl").request({ url = url })

    local contacts = {}
    local vcard_lines = vim.fn.split(reply.body, "\n")
    local name = nil
    local emails = {}
    for _, vline in pairs(vcard_lines) do
        if vim.startswith(vline, "BEGIN:") then
            name = nil
            emails = {}
        elseif vim.startswith(vline, "FN:") then
            name = vline:sub(4)
        elseif vim.startswith(vline, "N:") and name == nil then
            -- According to the vCard specification (source:
            -- https://datatracker.ietf.org/doc/html/rfc6350#section-6.2.2), the N identification property can be
            -- made up of up to 5 components, separated by semicolons.

            -- So it's easier to understand these steps, here's an example from the specification:
            -- N:Stevenson;John;Philip,Paul;Dr.;Jr.,M.D.,A.C.P.

            -- First, we separate these components.
            local components = vim.fn.split(vline:sub(3), ";")
            -- If there are more than 1 of them, we use only the second and first parts, in that order because
            -- these correspond to the contact's first and last names.
            if #components > 1 then
                components = { components[2], components[1] }
            end
            local joined_components = {}
            -- Again according to the specification, commas separate different parts of a component. So, we replace
            -- unescaped commas with spaces and remove the escape characters from commas.
            for _, component in ipairs(components) do
                local joined_component = component:gsub("([^\\]),", "%1 "):gsub("([^\\])\\,", "%1,")
                table.insert(joined_components, joined_component)
            end
            -- Finally, we join the components with spaces and remove any trailing whitespace in case one of the
            -- components was an empty string or ended with whitespace.
            name = vim.trim(table.concat(joined_components, " "))
        elseif vline:match("EMAIL") then
            table.insert(emails, vline:match(":(.*)"))
        elseif vim.startswith(vline, "END:") then
            if name ~= nil then
                for _, email in pairs(emails) do
                    table.insert(contacts, name .. " <" .. email .. ">")
                end
            end
        end
    end
    return contacts
end

return h.make_builtin({
    method = COMPLETION,
    filetypes = { "mail" },
    name = "email",
    generator = {
        fn = function(params, done)
            if not utils.is_in_header(params.content[params.row]) then
                done({ { items = {}, isIncomplete = false } })
                return
            end

            local get_candidates = function(_)
                local items = {}
                for k, v in ipairs(get_contacts("http://localhost:5232/mauro/contacts-colID34234")) do
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
