local Types = require("@Iro/Types/Parser")
local dumpNode = require("@Iro/Dump/AstNode")

return function(ast: Types.Ast): string
    local result = {}
    for _, node in ipairs(ast) do
        table.insert(result, dumpNode(node))
    end
    return table.concat(result, "\n")
end