M = {}

M.is_in_header = function(line)
    for _, header in pairs({ "Bcc:", "Cc:", "From:", "Reply-To:", "To:" }) do
        if vim.startswith(line, header) then
            return true
        end
    end
    return false
end

return M
