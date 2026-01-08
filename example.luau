local Iro = require("@Iro")

print("=== Basic Colors ===")
Iro.Print("<red>Red text</red>")
Iro.Print("<green>Green text</green>")
Iro.Print("<yellow>Yellow text</yellow>")
Iro.Print("<blue>Blue text</blue>")
Iro.Print("<cyan>Cyan text</cyan>")
Iro.Print("<magenta>Magenta text</magenta>")

print("\n=== Semantic Tags ===")
Iro.Print("<error>Error:</error> Something went wrong")
Iro.Print("<warning>Warning:</warning> Disk space low")
Iro.Print("<info>Info:</info> Process started")
Iro.Print("<success>Success:</success> Operation completed")

print("\n=== Styles ===")
Iro.Print("<bold>Bold text</bold>")
Iro.Print("<italic>Italic text</italic>")
Iro.Print("<underline>Underlined text</underline>")

print("\n=== Nesting ===")
Iro.Print("<red>I am <b>gay</b> and happy</red>")
Iro.Print("<bold>Server Status: <green>Online</green></bold>")
Iro.Print("<error>Error in <bold><cyan>middleware.lua</cyan></bold>: invalid syntax</error>")

print("\n=== Custom Tags ===")
Iro.RegisterTag("debug", { fg = "Magenta", italic = true })
Iro.Print("<debug>Debug information here</debug>")

Iro.RegisterTags({
    alert = { fg = "Red", bold = true, underline = true },
    hint = { fg = "Blue", italic = true },
    success_alt = { fg = "Green", bold = true },
})

Iro.Print("<alert>ALERT:</alert> Critical system failure")
Iro.Print("<hint>Hint:</hint> Try running with --verbose flag")
Iro.Print("<success_alt>All tests passed!</success_alt>")

print("\n=== Custom Configuration ===")
Iro.Config.SetForeground("Red", 91)
Iro.Config.SetForeground("Green", 92)
Iro.Print("<red>Bright red text</red>")
Iro.Print("<green>Bright green text</green>")

print("\n=== Complex Example ===")
Iro.RegisterTags({
    header = { fg = "White", bold = true, underline = true },
    value = { fg = "Cyan", bold = true },
    subtle = { fg = "Black" },
})

Iro.Print("<header>Configuration Report:</header>")
Iro.Print("  Environment: <value>production</value>")
Iro.Print("  Debug Mode: <subtle>disabled</subtle>")
Iro.Print("  Port: <value>8080</value>")

print("\n=== Log Function ===")
local styledText = Iro.Log("<green>Hello</green> <bold>World</bold>")
print("Stored styled text: " .. styledText)

Iro.Reset()
print("\n=== After Reset ===")
Iro.Print("<red>Back to normal red</red>")