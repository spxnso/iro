-- might need some refactoring, idk it works 

local ParserTypes = require("@Iro/Types/Parser")
local Types = require("@Iro/Types/Resolver")
local Color = require("@Iro/Color")
local TagRegistry = require("@Iro/TagRegistry")

local Resolver = {}
Resolver.__index = Resolver

function Resolver.new(ast: ParserTypes.Ast): Types.Resolver
    local self = setmetatable(
        {
            ast = ast,
        } :: Types.ResolverStructure,
        Resolver
    ) :: Types.Resolver
    return self
end

function Resolver:resolveNode(node: ParserTypes.AstNode, parentStyle: TagRegistry.TagStyle?): string
    if node.Kind == "Text" then
        return node.Value
    elseif node.Kind == "Tag" then
        return self:resolveTag(node, parentStyle)
    end
    return ""
end

function Resolver:resolveTag(tagNode: ParserTypes.TagNode, parentStyle: TagRegistry.TagStyle?): string
    local childrenOutput = ""

    local opts = TagRegistry.Get(tagNode.Name)

    for _, child in ipairs(tagNode.Children) do
        childrenOutput ..= self:resolveNode(child, opts)
    end

    if opts then
        childrenOutput = Color.apply(childrenOutput, opts)

        if parentStyle then
            childrenOutput = childrenOutput .. Color.GetCodes(parentStyle)
        end
    end

    return childrenOutput
end

function Resolver:Resolve(): string
    local output = ""

    for _, node in ipairs(self.ast) do
        output ..= self:resolveNode(node, nil)
    end

    return output
end

return Resolver