export type TokenizerStructure = {
	input: string,
	position: number,
}

export type TokenizerImplementation = {
	__index: TokenizerImplementation,
	new: (input: string) -> Tokenizer,
	isAtEnd: (self: Tokenizer) -> boolean,
	advance: (self: Tokenizer) -> string,
	peek: (self: Tokenizer) -> string,
	nextToken: (self: Tokenizer) -> Token,
	Tokenize: (self: Tokenizer) -> { Token },
	createToken: (kind: TokenKind, value: string?) -> Token,
}

export type Tokenizer = typeof(setmetatable({} :: TokenizerStructure, {} :: TokenizerImplementation))

export type TokenKind = | "Text" | "OpenTag" | "CloseTag" | "Eof"

export type Token = {
	Kind: TokenKind,
	Value: string?,
	Dump: string?,
}

return {}
