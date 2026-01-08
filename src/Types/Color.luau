export type ColorName = "Black" | "Red" | "Green" | "Yellow" | "Blue" | "Magenta" | "Cyan" | "White"

export type ColorOptions = {
    fg: ColorName?,
    bg: ColorName?,
    bold: boolean?,
    italic: boolean?,
    underline: boolean?,
}


export type ColorConfig = {
    foreground: { [ColorName]: number },
    background: { [ColorName]: number },
    styles: { [string]: number },
}

return {}