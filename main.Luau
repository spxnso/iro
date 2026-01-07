local Tokenizer = require("@Iro/Parser/Tokenizer")

local input = "<tag>Hello World!</tag>"
local tokenizer = Tokenizer.new(input)
local tokens = tokenizer:Tokenize()

for _, token in tokens do 
    print(token.Dump)
end