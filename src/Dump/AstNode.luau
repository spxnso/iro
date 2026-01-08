--!nolint 
-- shut up 

local Types = require("@Iro/Types/Parser")

local function dumpNode(node: Types.AstNode, indent: number?): string
    local indent = indent or 0
    local prefix = string.rep("  ", indent)

    if node.Kind == "Text" then
        local escaped = node.Value:gsub("\n", "\\n"):gsub("\t", "\\t")
        return prefix .. 'Text("' .. escaped .. '")'

    elseif node.Kind == "Tag" then
        local result = prefix .. "Tag(" .. node.Name .. ")"
        if #node.Children == 0 then
            return result .. " {}"
        end

        result ..= " {\n"
        for i, child in ipairs(node.Children) do
            result ..= dumpNode(child, indent + 1)
            if i < #node.Children then
                result ..= "\n"
            else
                result ..= "\n"
            end
        end
        result ..= prefix .. "}"
        return result
    end

    return prefix .. "Unknown"
end


return function(node: Types.AstNode): string
    return dumpNode(node, 0)
end