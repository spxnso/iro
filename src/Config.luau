--!nonstrict
-- luau shut the fuck up

local Types = require("@Iro/Types/Color")

local Config = {}

local defaultConfig: Types.ColorConfig = {
    foreground = {
        Black = 30,
        Red = 31,
        Green = 32,
        Yellow = 33,
        Blue = 34,
        Magenta = 35,
        Cyan = 36,
        White = 37,
    } :: { [Types.ColorName]: number },
    background = {
        Black = 40,
        Red = 41,
        Green = 42,
        Yellow = 43,
        Blue = 44,
        Magenta = 45,
        Cyan = 46,
        White = 47,
    } :: { [Types.ColorName]: number },
    styles = {
        Bold = 1,
        Italic = 3,
        Underline = 4,
        Reset = 0,
    } :: { [string]: number },
}

local currentConfig: Types.ColorConfig = {
    foreground = table.clone(defaultConfig.foreground) :: { [Types.ColorName]: number },
    background = table.clone(defaultConfig.background) :: { [Types.ColorName]: number },
    styles = table.clone(defaultConfig.styles) :: { [string]: number },
}

function Config.SetForeground(colorName: Types.ColorName, code: number)
    currentConfig.foreground[colorName] = code
end

function Config.SetBackground(colorName: Types.ColorName, code: number)
    currentConfig.background[colorName] = code
end

function Config.SetStyle(styleName: string, code: number)
    currentConfig.styles[styleName] = code
end

function Config.SetForegroundColors(colors: { [Types.ColorName]: number })
    for name, code in pairs(colors) do
        currentConfig.foreground[name] = code
    end
end

function Config.SetBackgroundColors(colors: { [Types.ColorName]: number })
    for name, code in pairs(colors) do
        currentConfig.background[name] = code
    end
end

function Config.Get(): Types.ColorConfig
    return {
        foreground = currentConfig.foreground,
        background = currentConfig.background,
        styles = currentConfig.styles,
    }
end

function Config.Reset()
    currentConfig = {
        foreground = table.clone(defaultConfig.foreground) :: { [Types.ColorName]: number },
        background = table.clone(defaultConfig.background) :: { [Types.ColorName]: number },
        styles = table.clone(defaultConfig.styles) :: { [string]: number },
    }
end

function Config.Apply(config: Types.ColorConfig)
    if config.foreground then
        currentConfig.foreground = table.clone(config.foreground) :: { [Types.ColorName]: number }
    end
    if config.background then
        currentConfig.background = table.clone(config.background) :: { [Types.ColorName]: number }
    end
    if config.styles then
        currentConfig.styles = table.clone(config.styles) :: { [string]: number }
    end
end

return Config