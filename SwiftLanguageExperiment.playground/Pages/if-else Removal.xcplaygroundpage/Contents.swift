
#if canImport(…)
#if arch(…)
#if compiler(…)
#if os(…)
#if platform(…)
#if targetEnvironment(…)





import Foundation

//using dictionary

func performOp(operationName: String) {
    if (operationName == "op1"){
        print("operation 1 done")
    }else if (operationName == "op2") {
        print("operation 2 done")
    }else {
        print("other operation done")
    }
}

var operations: [String: (()->())] = [:]

operations["op1"] = {
    print("operation 1 done")
}

operations["op2"] = {
    print("operation 2 done")
}

func performOperationWithDict(_ operationName: String) {
    guard let operation = operations[operationName] else {
        return
    }
    operation()
}

performOperationWithDict("op2")


// using strategy pattern removing conditional (if else OR switch) statements

struct LoggerBasic {

    enum LogStyle {
        case lowercase
        case uppercase
        case capitalized
    }

    let style: LogStyle

    func log(_ message: String) {
        switch style {
        case .lowercase:
            print(message.lowercased())
        case .uppercase:
            print(message.uppercased())
        case .capitalized:
            print(message.capitalized)
        }
    }
}

// into this

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
 
