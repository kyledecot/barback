import Foundation

let dispatchGroup = DispatchGroup()
let cli = CLI(arguments: CommandLine.arguments)

dispatchGroup.enter()

cli.run() { success in
    if (success) {
        print("SUCCESSFUL")
    } else {
        print("UNSUCCESSFUL")
    }
    
    dispatchGroup.leave()
}

dispatchGroup.notify(queue: DispatchQueue.main) {
    exit(EXIT_SUCCESS)
}

dispatchMain()
