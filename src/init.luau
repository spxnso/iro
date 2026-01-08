local Tokenizer = require("@Iro/Parser/Tokenizer")
local Parser = require("@Iro/Parser/Parser")
local Resolver = require("@Iro/Resolver")
local TagRegistry = require("@Iro/TagRegistry")
local Config = require("@Iro/Config")

local Iro = {}

Iro.Config = Config
Iro.TagRegistry = TagRegistry

function Iro.Log(input: string): string
    local tokenizer = Tokenizer.new(input)
    local tokens = tokenizer:Tokenize()
    local parser = Parser.new(tokens)
    local ast = parser:Parse()
    local resolver = Resolver.new(ast)
    return resolver:Resolve()
end

function Iro.Print(input: string)
    print(Iro.Log(input))
end

function Iro.RegisterTag(name: string, style: TagRegistry.TagStyle)
    TagRegistry.Register(name, style)
end

function Iro.RegisterTags(tags: { [string]: TagRegistry.TagStyle })
    TagRegistry.RegisterBulk(tags)
end

function Iro.Reset()
    TagRegistry.Reset()
    Config.Reset()
end

return Iro