import Foundation
import SwiftUI

// Simple in struct
struct Meeting {
    var name: String
    var state: String
    var reminderDate: Date?

    mutating func cancel(withMessage message: String) {
        state = message
        reminderDate = nil
    }
}

// Enum
enum Operation {
    case add(String)
    case remove(String)
    case update(String)
    case group([Operation])
}

extension Operation {
    mutating func append(_ operation: Operation) {
        self = .group([self, operation])
    }
}

// Struct mutating/resetting working copy

struct Canvas {
    var backgroundColor: Color?
    var foregroundColor: Color?
    var images = [Image]()

    mutating func reset() {
        self = Canvas()
    }
}

// Mutating in protocol

protocol Resettable {
    init()
    mutating func reset()
}

extension Resettable {
    mutating func reset() {
        self = Self()
    }
}

struct Canvas2: Resettable {
    var backgroundColor: Color?
    var foregroundColor: Color?
    var images = [Image]()
}

// Non mutating key words
//mutation in non-mutating context with property warraper

@propertyWrapper struct PersistedFlag {
    var wrappedValue: Bool {
        get {
            defaults.bool(forKey: key)
        }
        nonmutating set {
            defaults.setValue(newValue, forKey: key)
        }
    }

    var key: String
    private let defaults = UserDefaults.standard
}

struct Employee {
    private (set) var name: String
    @PersistedFlag private (set) var workingStatus: Bool

    mutating func updateName(newName: String){
        name = newName
    }
    
    func updateWorkingStatus(status: Bool){
         workingStatus = status
    }
}

