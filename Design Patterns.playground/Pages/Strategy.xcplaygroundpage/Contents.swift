import Foundation

// What
protocol LoggerStrategy {
    func log(_ message: String)
}

// Who
struct Logger {
    let strategy: LoggerStrategy

    func log(_ message: String) {
        strategy.log(message)
    }
}

// How
struct LowercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.lowercased())
    }
}

struct UppercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.uppercased())
    }
}

struct CapitalizedStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.capitalized)
    }
}

var logger = Logger(strategy: CapitalizedStrategy())
logger.log("my first strategy")  // My First Strategy
logger = Logger(strategy: UppercaseStrategy())
logger.log("my first strategy")  // MY FIRST STRATEGY
logger = Logger(strategy: LowercaseStrategy())
logger.log("my first strategy")  // my first strategy
 
