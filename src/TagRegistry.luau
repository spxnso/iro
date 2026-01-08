local ColorTypes = require("@Iro/Types/Color")

export type TagStyle = {
    fg: ColorTypes.ColorName?,
    bg: ColorTypes.ColorName?,
    bold: boolean?,
    italic: boolean?,
    underline: boolean?,
}

local TagRegistry = {}

local defaultTags: { [string]: TagStyle } = {
    error = { fg = "Red", bold = true },
    warning = { fg = "Yellow", bold = true },
    info = { fg = "Cyan", italic = true },
    success = { fg = "Green", bold = true },
    red = { fg = "Red" },
    green = { fg = "Green" },
    yellow = { fg = "Yellow" },
    blue = { fg = "Blue" },
    cyan = { fg = "Cyan" },
    magenta = { fg = "Magenta" },
    white = { fg = "White" },
    black = { fg = "Black" },
    bold = { bold = true },
    italic = { italic = true },
    underline = { underline = true },
    b = { bold = true },
    i = { italic = true },
    u = { underline = true },
}

local registry: { [string]: TagStyle } = {}

for name, style in pairs(defaultTags) do
    registry[name] = style
end

function TagRegistry.Register(name: string, style: TagStyle)
    registry[name] = style
end

function TagRegistry.RegisterBulk(tags: { [string]: TagStyle })
    for name, style in pairs(tags) do
        registry[name] = style
    end
end

function TagRegistry.Get(name: string): TagStyle?
    return registry[name]
end

function TagRegistry.Exists(name: string): boolean
    return registry[name] ~= nil
end

function TagRegistry.GetAll(): { [string]: TagStyle }
    return registry
end

function TagRegistry.Reset()
    registry = {}
    for name, style in pairs(defaultTags) do
        registry[name] = style
    end
end

function TagRegistry.Remove(name: string)
    registry[name] = nil
end

return TagRegistry