# Iro

**Iro** (色, a Japanese word for "Color") is a lightweight Luau library for rich, terminal-style colored text output.

## Usage

### Quick Start

Import Iro and use the API:

```lua
local Iro = require("@Iro")

Iro.Print("<red>Error:</red> something went wrong")
Iro.Print("<bold>Important</bold> message")
Iro.Print("<green>Success!</green>")
```

### Built-in Tags

Iro comes with semantic and color tags:

**Semantic Tags:**
- `<error>` - Red text, bold
- `<warning>` - Yellow text, bold
- `<info>` - Cyan text, italic
- `<success>` - Green text, bold

**Color Tags:**
- `<red>`, `<green>`, `<yellow>`, `<blue>`, `<cyan>`, `<magenta>`, `<white>`, `<black>`

**Style Tags:**
- `<bold>` or `<b>` - Bold text
- `<italic>` or `<i>` - Italic text
- `<underline>` or `<u>` - Underlined text

### Nesting Tags

Tags can be nested for combined effects:

```lua
Iro.Print("<error>Error: <bold>critical failure</bold></error>")
Iro.Print("<bold><red>CRITICAL</red></bold> system failure")
```

### Custom Tags

Register your own tags:

```lua
Iro.RegisterTag("debug", { fg = "Magenta", italic = true })
Iro.Print("<debug>Debug information</debug>")

Iro.RegisterTags({
    alert = { fg = "Red", bold = true, underline = true },
    hint = { fg = "Blue", italic = true },
    muted = { fg = "Black" },
})

Iro.Print("<alert>Important!</alert>")
Iro.Print("<hint>Try this instead</hint>")
```

### Configuration

Customize ANSI color codes for different terminals:

```lua
Iro.Config.SetForeground("Red", 91)    -- Bright red
Iro.Config.SetForeground("Green", 92)  -- Bright green
Iro.Config.SetBackground("Blue", 104)  -- Bright blue background

Iro.Config.SetForegroundColors({
    Red = 91,
    Green = 92,
    Yellow = 93,
})
```

Reset to defaults:

```lua
Iro.Reset()
```

### API Reference

#### `Iro.Log(input: string): string`

Parse and resolve tags, returning the styled string without printing.

```lua
local styled = Iro.Log("<green>Hello</green> <bold>World</bold>")
print(styled)
```

#### `Iro.Print(input: string)`

Parse, resolve, and print styled text to console.

```lua
Iro.Print("<error>Failed!</error>")
```

#### `Iro.RegisterTag(name: string, style: TagStyle)`

Register a single custom tag.

```lua
Iro.RegisterTag("custom", { fg = "Cyan", bold = true })
```

#### `Iro.RegisterTags(tags: { [string]: TagStyle })`

Register multiple custom tags at once.

```lua
Iro.RegisterTags({
    tag1 = { fg = "Red" },
    tag2 = { fg = "Blue", bold = true },
})
```

#### `Iro.Reset()`

Reset all custom tags and color configuration to defaults.

```lua
Iro.Reset()
```

### TagStyle Options

When registering custom tags, use the `TagStyle` type:

```lua
export type TagStyle = {
    fg: ColorName?,           -- Foreground color
    bg: ColorName?,           -- Background color
    bold: boolean?,           -- Bold text
    italic: boolean?,         -- Italic text
    underline: boolean?,      -- Underlined text
}
```

**ColorName values:** `"Black"`, `"Red"`, `"Green"`, `"Yellow"`, `"Blue"`, `"Magenta"`, `"Cyan"`, `"White"`

### Configuration API

#### `Iro.Config.SetForeground(colorName: ColorName, code: number)`

Set ANSI code for a foreground color.

#### `Iro.Config.SetBackground(colorName: ColorName, code: number)`

Set ANSI code for a background color.

#### `Iro.Config.SetStyle(styleName: string, code: number)`

Set ANSI code for a style.

#### `Iro.Config.SetForegroundColors(colors: { [ColorName]: number })`

Set multiple foreground colors at once.

#### `Iro.Config.SetBackgroundColors(colors: { [ColorName]: number })`

Set multiple background colors at once.

#### `Iro.Config.Get(): ColorConfig`

Get current configuration.

#### `Iro.Config.Reset()`

Reset configuration to defaults.

#### `Iro.Config.Apply(config: ColorConfig)`

Apply a full configuration.

## Examples

### Error Logging

```lua
Iro.Print("<error>Error:</error> Failed to load file")
Iro.Print("<warning>Warning:</warning> Disk space low")
Iro.Print("<success>Success:</success> Operation completed")
```

### Custom Theme

```lua
Iro.RegisterTags({
    header = { fg = "White", bold = true, underline = true },
    value = { fg = "Cyan", bold = true },
    subtle = { fg = "Black" },
})

Iro.Print("<header>Configuration:</header>")
Iro.Print("  Host: <value>localhost</value>")
Iro.Print("  Port: <subtle>8080</subtle>")
```

### Complex Nesting

```lua
Iro.Print("<bold>Server Status: <green>Online</green></bold>")
Iro.Print("<error>Error in <bold><cyan>middleware.lua</cyan></bold>: invalid syntax</error>")
```

## Installation

Add to your `pesde.toml`:

```toml
[dependencies]
iro = { git = "https://github.com/spxnso/iro" }
```

## License

MIT