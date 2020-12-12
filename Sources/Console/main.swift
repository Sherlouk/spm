import Foundation
import ConsoleKit

let console: Console = Terminal()
var input = CommandInput(arguments: CommandLine.arguments)
var context = CommandContext(console: console, input: input)

var commands = Commands(enableAutocomplete: true)
commands.use(GraphCommand(), as: "graph", isDefault: false)

do {
    let group = commands.group()
    try console.run(group, input: input)
} catch {
    console.error("\(error)")
    exit(EXIT_FAILURE)
}
