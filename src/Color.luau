local Types = require("@Iro/Types/Color")

local Config = require("@Iro/Config")

local Color = {}

local function buildSgr(codes: { number }): string
    if #codes == 0 then
        return ""
    end
    return "\27[" .. table.concat(codes, ";") .. "m"
end

function Color.GetCodes(opts: Types.ColorOptions?): string
    if not opts then
        return ""
    end

    local config = Config.Get()
    local codes: { number } = {}

    if opts.fg then
        local code = config.foreground[opts.fg]
        if code then
            table.insert(codes, code)
        end
    end

    if opts.bg then
        local code = config.background[opts.bg]
        if code then
            table.insert(codes, code)
        end
    end

    if opts.bold then
        table.insert(codes, config.styles.Bold)
    end
    if opts.italic then
        table.insert(codes, config.styles.Italic)
    end
    if opts.underline then
        table.insert(codes, config.styles.Underline)
    end

    if #codes == 0 then
        return ""
    end

    return buildSgr(codes)
end

function Color.apply(text: string, opts: Types.ColorOptions?): string
    if not opts then
        return text
    end

    local config = Config.Get()
    local codes: { number } = {}

    if opts.fg then
        local code = config.foreground[opts.fg]
        if code then
            table.insert(codes, code)
        end
    end

    if opts.bg then
        local code = config.background[opts.bg]
        if code then
            table.insert(codes, code)
        end
    end

    if opts.bold then
        table.insert(codes, config.styles.Bold)
    end
    if opts.italic then
        table.insert(codes, config.styles.Italic)
    end
    if opts.underline then
        table.insert(codes, config.styles.Underline)
    end

    if #codes == 0 then
        return text
    end

    local startSeq = buildSgr(codes)
    local resetSeq = buildSgr({ config.styles.Reset })

    return startSeq .. text .. resetSeq
end

function Color.Fg(name: Types.ColorName): string
    local config = Config.Get()
    local code = config.foreground[name]
    if code then
        return buildSgr({ code })
    end
    return ""
end

function Color.Bg(name: Types.ColorName): string
    local config = Config.Get()
    local code = config.background[name]
    if code then
        return buildSgr({ code })
    end
    return ""
end

function Color.Bold(text: string): string
    local config = Config.Get()
    return buildSgr({ config.styles.Bold }) .. text .. buildSgr({ config.styles.Reset })
end

function Color.Italic(text: string): string
    local config = Config.Get()
    return buildSgr({ config.styles.Italic }) .. text .. buildSgr({ config.styles.Reset })
end

function Color.Underline(text: string): string
    local config = Config.Get()
    return buildSgr({ config.styles.Underline }) .. text .. buildSgr({ config.styles.Reset })
end

function Color.Reset(): string
    local config = Config.Get()
    return buildSgr({ config.styles.Reset })
end

return Color