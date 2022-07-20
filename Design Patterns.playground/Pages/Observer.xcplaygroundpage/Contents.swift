import Combine

// MARK: Observer design pattern -> One object observes changes on another object

public class User {
    @Published var name: String
    public init(name: String) {
        self.name = name
    }
}

let user = User(name: "khawar")
let publisher = user.$name
var subscriber: AnyCancellable = publisher.sink {
    print("user name is \($0)")
}

user.name = "Khawar Ali"
