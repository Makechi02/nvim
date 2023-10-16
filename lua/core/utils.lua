local fn = vim.fn

local M = {}

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @low: the lower value for this range
--- @high: the upper value for this range
function M.rand_int(low, high)
    -- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
    math.randomseed(os.time())
    return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @seq: the sequence to choose an element
function M.rand_element(seq)
    local idx = M.rand_int(1, #seq)
    return seq[idx]
end

function M.executable(name)
    if fn.executable(name) > 0 then
        return true
    end

    return false
end

M.load_config = function()
    local config = require "core.default_config"

    return config
end

return M

