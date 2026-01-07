local Types = require("@Iro/types/Tokenizer")

local Tokenizer = {}
Tokenizer.__index = Tokenizer

function Tokenizer.new(input: string): Types.Tokenizer
	local self = setmetatable(
		{
			input = input,
			position = 1,
		} :: Types.TokenizerStructure,
		Tokenizer
	) :: Types.Tokenizer
	return self
end

function Tokenizer.createToken(kind: Types.TokenKind, value: string?): Types.Token
	local Token = { Kind = kind, Value = value }

	Token.Dump = require("@Iro/Dump/Token")(Token)

	return Token
end

function Tokenizer.isAtEnd(self: Types.Tokenizer): boolean
	return self.position > #self.input
end

function Tokenizer.advance(self: Types.Tokenizer): string
	local char: string = self.input:sub(self.position, self.position)
	self.position = self.position + 1
	return char
end

function Tokenizer.peek(self: Types.Tokenizer): string
	if self:isAtEnd() then
		return ""
	end
	return self.input:sub(self.position, self.position)
end

function Tokenizer.nextToken(self: Types.Tokenizer): Types.Token
    if self:isAtEnd() then
        return self.createToken("Eof")
    end

    local char: string = self:advance()

    if char == "<" then
        local kind = "OpenTag"

        if self:peek() == "/" then
            kind = "CloseTag"
            self:advance()
        end

        local nameStart = self.position

        while not self:isAtEnd() and self:peek() ~= ">" do
            self:advance()
        end

        local tagName = self.input:sub(nameStart, self.position - 1)
        
        if not self:isAtEnd() then
            self:advance()
        end

        return self.createToken(kind, tagName)
    else
        local start = self.position - 1
        while not self:isAtEnd() and self:peek() ~= "<" do
            self:advance()
        end
        local text = self.input:sub(start, self.position - 1)
        return self.createToken("Text", text)
    end
end


function Tokenizer.Tokenize(self: Types.Tokenizer): { Types.Token }
	local tokens: { Types.Token } = {}
	while not self:isAtEnd() do
		table.insert(tokens, self:nextToken())
	end
	return tokens
end

return Tokenizer
