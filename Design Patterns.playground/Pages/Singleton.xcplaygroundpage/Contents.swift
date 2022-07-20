import Foundation

// MARK: - Singleton -> only one instance of the class

class MySingleton {
    static let sharedInstance = MySingleton()
    var number = 0
    private init() {}
}

var singleA = MySingleton.sharedInstance
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance

singleB.number = 2

print(singleA.number)
print(singleB.number)
print(singleC.number)

singleA.number = 3

print(singleA.number)
print(singleB.number)
print(singleC.number)
