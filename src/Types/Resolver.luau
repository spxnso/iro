local ParserTypes = require("@Iro/Types/Parser")

export type ResolverStructure = {
    ast: ParserTypes.Ast,
}

export type ResolverImplementation = {
	__index: ResolverImplementation,
    new: (ast: ParserTypes.Ast) -> Resolver,
    resolveNode: (self: Resolver, node: ParserTypes.AstNode) -> string,
    resolveTag: (self: Resolver, tagNode: ParserTypes.TagNode) -> string,
    Resolve: (self: Resolver) -> string,
}

export type Resolver = typeof(setmetatable({} :: ResolverStructure, {} :: ResolverImplementation))

return {}