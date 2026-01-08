local Tokenizer = require("@Iro/Parser/Tokenizer")
local Parser = require("@Iro/Parser/Parser")

local tokenizer = Tokenizer.new("<error>Failed to connect</error>\n<info>User <b>logged</b> in</info>\n<warning>Low disk space</warning>")
local parser = Parser.new(tokenizer:Tokenize())

local ast = parser:Parse()

local dump = require("@Iro/Dump/Ast")

print(dump(ast))