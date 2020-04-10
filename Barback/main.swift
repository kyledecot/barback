import Foundation

let dispatchGroup = DispatchGroup()
let cli = CLI(arguments: CommandLine.arguments)

var exitCode = EXIT_FAILURE

dispatchGroup.enter()

cli.run { success in
    if success {
        exitCode = EXIT_SUCCESS
    }

    dispatchGroup.leave()
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(exitCode)
}

dispatchMain()
