local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING
local RANGE_FORMATTING = methods.internal.RANGE_FORMATTING

return h.make_builtin({
    -- method = { FORMATTING, RANGE_FORMATTING },
    method = { RANGE_FORMATTING },
    filetypes = { "python" },
    generator_opts = {
        command = "pyment",
        args = {
            "--output",
            "numpydoc",
            "--write",
            "-",
        },
        to_stdin = true,
    },
    factory = h.formatter_factory,
})
