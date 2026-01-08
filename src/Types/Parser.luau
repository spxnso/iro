local TokenizerTypes = require("@Iro/Types/Tokenizer")

export type ParserStructure = {
	tokens: { TokenizerTypes.Token },
	position: number,
}

export type ParserImplementation = {
	__index: ParserImplementation,
	new: (tokens: { TokenizerTypes.Token }) -> Parser,
	isAtEnd: (self: Parser) -> boolean,
	current: (self: Parser) -> TokenizerTypes.Token,
	advance: (self: Parser) -> TokenizerTypes.Token,
	peek: (self: Parser, offset: number) -> TokenizerTypes.Token,
	parseChildren: (self: Parser, expectedClosingTag: string) -> { AstNode },
	parseTag: (self: Parser) -> TagNode,
	Parse: (self: Parser) -> { AstNode },
}

export type Parser = typeof(setmetatable({} :: ParserStructure, {} :: ParserImplementation))

export type AstNode = TextNode | TagNode

export type TextNode = {
	Kind: "Text",
	Value: string,
}

export type TagNode = {
	Kind: "Tag",
	Name: string,
	Children: { AstNode },
}

export type Ast = { AstNode }

return {}
