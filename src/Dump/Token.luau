local Types = require("@Iro/Types/Tokenizer")

return function (token: Types.Token): string
    if token.Value then
        return ("Token(%s, \"%s\")"):format(token.Kind, token.Value)
    else
        return ("Token(\"%s\")"):format(token.Kind)
    end
end