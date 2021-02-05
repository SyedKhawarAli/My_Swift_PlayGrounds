
// MARK: - Data for examples

let names = ["khawar", "Ali", "Shah"]
let nThings: [Any] = [1, "2", "three"]
let numbers = [1, 2, 3, 4, 5]
let optionalNum = [1, nil, 7]
let twoDdata = [["dilawar", "ali"], ["khawar", "shah"]]
let dict = ["key1": "value1", "key2": "value2"]
let twoDdict = [["key1": "value1", "key2": "value2"], ["key3": "value3"]]

// MARK: - Reduce

// exp 1
let oThings = nThings.reduce("") { "\($0)\($1)," }
print(oThings)

// exp 2
let sum = numbers.reduce(0, +)
print(sum)

// exp 3
let sumSquare = numbers.reduce(0, mySum)
func mySum(a: Int, b: Int) -> Int {
    return (a + b + b)
}

print(sumSquare)

// MARK: - Map

// exp 1
let uName = names.map { (name) -> String in
    name + "T"
}

print(uName)

// exp 2
let upercaseName = names.map { $0.uppercased() }
print(upercaseName)

// MARK: - Flatmap

// exp 1
let upperletter = names.flatMap { $0.uppercased() }
print(upperletter)

// exp 2
let upercaseNames = twoDdata.flatMap { (data) -> [String] in
    data.map { (item) -> String in
        item.uppercased()
    }
}

print(upercaseNames)

// exp 3
let shortForm = twoDdata.flatMap { $0.map { $0.uppercased() }}
print(shortForm)

// exp 3
let arr = optionalNum.flatMap { $0 }
print(arr)

// exp 4
let dictArr = twoDdict.flatMap { $0 }
print(dictArr)

var storeDict = [String: String]()
dictArr.forEach {
    storeDict[$0.0] = $0.1
}

print(storeDict)

// MARK: - compactMap

// exp 1
let opArr = optionalNum.compactMap { $0 }
print(opArr)

// MARK: - filter

// exp 1
let evenNum = numbers.filter { $0 % 2 == 0 }
print(evenNum)

// MARK: - Passing func as parameter

// exp 1
func add(a: Double, b: Double) -> Double {
    return a + b
}

func mul(a: Double, b: Double) -> Double {
    return a * b
}

func doMath(op: (_ x: Double, _ y: Double) -> Double, num1: Double, num2: Double) -> Double {
    return op(num1, num2)
}

let addRes = doMath(op: add, num1: 2, num2: 5)
print(addRes)
let mulRes = doMath(op: mul, num1: 2, num2: 5)
print(mulRes)
let plusRes = doMath(op: +, num1: 2, num2: 5)
print(plusRes)

// MARK: - Clousers, Passing cloures in function as a paramerters

func myClouser(param: (String) -> Void) {
    // code
    param("hello world")
}

myClouser { str in
    print(str)
}

// MARK: - test things

// observer call on applending data in an array
var s = [0] {
    didSet {
        print("didSet")
    }
    willSet {
        print("willSet")
    }
}

s.append(1)
