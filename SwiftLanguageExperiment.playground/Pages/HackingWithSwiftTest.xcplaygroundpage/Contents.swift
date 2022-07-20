//: [Previous](@previous)

import Foundation

//Question 1
//In the code below, what data type is testVar?

//let names = ["Pilot": "Wash", "Doctor": "Simon"]
//
//for (key, value) in names.enumerated() {
//    let testVar = value
//}

// Q.2
//#if canImport(…)
//#if arch(…)
//#if compiler(…)
//#if os(…)
//#if platform(…)
//#if targetEnvironment(…)

//Question 3
//What is the output from the following code?

struct User {
    let name: String
}

let users = [User(name: "Eric"), User(name: "Maeve"), User(name: "Otis")]
let mapped = users.map(\.name)
print(mapped)

//Question 4
//What output will be produced by the code below?

//func square<T>(_ value: T) -> T {
//    return value * value
//}
//
//print(square(5))

// Q.8
//var names = [String]()
//names.append("Amy")
//let example1 = names.removeLast()
//let example2 = names.removeLast()
//print(names)

// Q.9
var spaceships1 = Set<String>()
spaceships1.insert("Serenity")
spaceships1.insert("Enterprise")
spaceships1.insert("TARDIS")

let spaceships2 = spaceships1

if spaceships1.isSubset(of: spaceships2) {
    print("This is a subset")
} else {
    print("This is not a subset")
}

// Q.10
//enum Weather: CaseIterable {
//    case sunny
//    case windy(speed: Int)
//    case rainy
//}
//
//print(Weather.allCases.count)

// Q.11
//What output will be produced by the code below?

let status = "shiny"

for (position, character) in status.reversed().enumerated() where position % 2 == 0 {
    print("\(position): \(character)")
}

// Q.12
//What output will be produced by the code below?

let (captain, engineer, doctor) = ("Mal", "Kailee", "Simon")
print(engineer)

//Question 13/20
//What output will be produced by the code below?

func foo(_ number: Int) -> Int {
    func bar(_ number: Int) -> Int {
        return number * 5
    }
    
    return number * bar(3)
}

print(foo(2))

//Question 14/20
//Once this code is executed, how many items will be in the result array?

//let names: [String?] = ["Barbara", nil, "Janet", nil, "Peter", nil, "George"]
//let result = names.compactMap { $0 }
//print(result)

//Question 15/20
//Given the code below, what data type will be assigned to test?

//enum Planet: Int {
//    case Mercury = 1
//    case Venus
//    case Earth
//    case Mars
//}
//
//let test = Planet(rawValue: 3)

//Question 16/20
//What will result be set to after this code runs?

//let result = Result { try String(contentsOfFile: "pathToFileThatDoesNotExist") }

//Question 17/20
//Please read the code below:

//let data: [Any?] = ["Bill", nil, 69, "Ted"]
//
//for datum in data where datum is String? {
//    print(datum)
//}
//
//for case let .some(datum) in data where datum is String? {
//    print(datum)
//}

//As you can see, there are two for loops, both operating on the data array. Which loop prints the most lines?
                                    
//Question 18/20
//What output will be produced by the code below?

func foo(_ function: (Int) -> Int) -> Int {
    return function(function(5))
}

func bar<T: BinaryInteger>(_ number: T) -> T {
    return number * 3
}

print(foo(bar))

//Question 19/20
//What output will be produced by the code below?

func getNumber() -> Int {
    print("Fetching number...")
    return 5
}

func printStatement(_ result: @autoclosure () -> Bool) {
    // print("Here is the number: \(result())")
    print("Nothing to see here.")
}

printStatement(getNumber() == 5)

//Question 20/20
//When this code is executed, what will example2 be set to?

var names = [String]()
names.append("Amy")

let example1 = names.popLast()
let example2 = names.popLast()

// Q. whats wrong in it

//class ViewController: UIViewController {
//    @IBOutlet var alert: UILabel!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let frame: CGRect = CGRect(x: 100, y: 100, width: 100, height: 50)
//        self.alert = UILabel(frame: frame)
//        self.alert.text = "Please wait..."
//        self.view.addSubview(self.alert)
//    }
//    DispatchQueue.global(qos: .default).async {
//        sleep(10)
//        self.alert.text = "Waiting over"
//    }
//}

let N = 15958
//let numbersArray = String(N).compactMap({ $0.wholeNumberValue })
//print(numbersArray)
//numbersArray.la
//let number = numbersArray.reduce(0, { $0 * 10 + $1 })
//print(number)
//var numbersWithoutFive: [Int] = []
//numbersWithoutFive.append(number)
let isNumberPositive = N > 0
var numbersWithoutFive: [Int] = []
let numbersArray = String(N).compactMap({ $0.wholeNumberValue })
for (index, number) in numbersArray.enumerated() {
    var tempArray = numbersArray
    if number == 5 {
        tempArray.remove(at: index)
        let number = tempArray.reduce(0, { $0 * 10 + $1 })
        numbersWithoutFive.append(isNumberPositive ? number : (-1*number))
    }
}
numbersWithoutFive.sort()
print(numbersWithoutFive.last ?? 0)


var A = [100, 200, 100]
var B = [50,100, 100]
let X = 100
let Y = 100

func solution(_ A : inout [Int], _ B : inout [Int], _ X : Int, _ Y : Int) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    for (index, num) in A.enumerated() {
        if abs(num - X) < 21 && abs(B[index] - Y) < 21 {
            return index
        }
    }
    return -1
}
print(solution(&A, &B, X, Y))
