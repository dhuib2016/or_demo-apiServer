-- function reference
local log = ngx.log
local WARN = ngx.WARN
local match = ngx.re.match
local gsub = ngx.re.gsub
local sub = string.sub
-- include
local lfs = require("lfs")
local regex = [[handlers\/\w+\/\w+]]

local handler = function(fullPathFile, fileName, requireTable)
    local captures, matchErr = match(fullPathFile, regex, "jo")
    if not captures then
        log(WARN, fullPathFile, " match \"", regex, "\" failed: ", matchErr or "no match")
        return
    end

    local capture = captures[0]
    local requireName, _, gsubErr = gsub(capture, "/", ".", "jo")
    if not requireName then
        log(WARN, capture, " gsub / to . failed: ", gsubErr or "no match")
        return
    end

    local key = sub(fileName, 1, -5)
    requireTable[key] = require(requireName)
end

local autoRequire
autoRequire = function(suffix, path)
    if suffix then
        path = lfs.currentdir()..suffix
    end
    local requireTable = {}
    for f in lfs.dir(path) do
        if f ~= "." and f ~= ".." then
            local fullPathFile = path.."/"..f
            local attr, err = lfs.attributes(fullPathFile)
            if attr then
                local mode = attr.mode
                if mode == "directory" then
                    autoRequire(fullPathFile)
                else
                    handler(fullPathFile, f, requireTable)
                end
            else
                log(WARN, "get file attributes failed: ", err)
            end
        end
    end

    return requireTable
end

return autoRequire
