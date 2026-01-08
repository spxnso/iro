local TokenizerTypes = require("@Iro/Types/Tokenizer")
local Types = require("@Iro/Types/Parser")
local Parser = {}
Parser.__index = Parser

function Parser.new(tokens: { TokenizerTypes.Token }): Types.Parser
	local self = setmetatable(
		{
            tokens = tokens,
			position = 1,
		} :: Types.ParserStructure,
		Parser
	) :: Types.Parser
	return self
end

function Parser.isAtEnd(self: Types.Parser): boolean
    return self.position > #self.tokens
end

function Parser.current(self: Types.Parser): TokenizerTypes.Token
    return self.tokens[self.position]
end

function Parser.advance(self: Types.Parser): TokenizerTypes.Token
	local token = self.current(self)
	self.position = self.position + 1
	return token
end

function Parser.peek(self: Types.Parser, offset: number): TokenizerTypes.Token
	return self.tokens[self.position + offset]
end

function Parser.parseChildren(self: Types.Parser, expectedClosingTag: string): { Types.AstNode }
    local children: { Types.AstNode } = {}

    while not self:isAtEnd() do
        local token = self:current()

        if token.Kind == "Text" then
            table.insert(children, {
                Kind = "Text",
                Value = token.Value or "",
            } :: Types.TextNode)
            self:advance()
        elseif token.Kind == "OpenTag" then
            table.insert(children, self:parseTag())
        elseif token.Kind == "CloseTag" then
            if token.Value == expectedClosingTag then
                self:advance()
                return children
            else
                error("Mismatched closing tag: expected </" .. expectedClosingTag .. ">, got </" .. (token.Value or "") .. ">")
            end

        else
            self:advance()
        end
    end

    error("Unexpected EOF: expected closing tag </" .. expectedClosingTag .. ">")
end

function Parser.parseTag(self: Types.Parser): Types.TagNode
    local openTag = self:advance()

    if not openTag.Value then
        error("Expected tag name, got nil")
    end

    local tagName = openTag.Value

    local children = self:parseChildren(tagName)

    return {
        Kind = "Tag",
        Name = tagName,
        Children = children,
    } :: Types.TagNode
end

function Parser.Parse(self: Types.Parser): Types.Ast
    local nodes: { Types.AstNode } = {}

    while not self:isAtEnd() do
        local token = self:current()

        if token.Kind == "Text" then
            table.insert(nodes, {
                Kind = "Text",
                Value = token.Value or "",
            } :: Types.TextNode)
            self:advance()

        elseif token.Kind == "OpenTag" then
            table.insert(nodes, self:parseTag())

        elseif token.Kind == "CloseTag" then
            error("Unexpected closing tag: </" .. (token.Value or "") .. ">")

        else
            self:advance()
        end
    end

    return nodes
end


return Parser