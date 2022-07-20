import Foundation
import SwiftUI

struct Person {
    let name: String
    let age: Int
}

struct PeopleViewModel {
    var people: [Person]
    
    lazy var oldest: Person? = {
        print("oldest person calculated")
        return people.max(by: { $0.age < $1.age })
    }()
    
    let robotAge: Int = {
        print("robot Int initialized")
        return 100
    }()
    
    init(people: [Person]) {
        self.people = people
        print("View model initialized")
    }
}

var viewModel = PeopleViewModel(people: [
    Person(name: "Antoine", age: 30),
    Person(name: "Jaap", age: 3),
    Person(name: "Lady", age: 3),
    Person(name: "Maaike", age: 27)
])

//Print: robot Int initialized
//Print: View model initialized
print(viewModel.oldest ?? 0)
// Prints: "oldest person calculated"
// Prints: Person(name: "Antoine", age: 30)
print(viewModel.oldest ?? 0)
// Prints: Person(name: "Antoine", age: 30)
print(viewModel.robotAge)
//Print: 100
print(viewModel.robotAge)
//Print: 100
viewModel.people.append(Person(name: "Jan", age: 69))
print(viewModel.oldest ?? 0) //Will not be intilaized again
// Prints: Person(name: "Antoine", age: 30)

