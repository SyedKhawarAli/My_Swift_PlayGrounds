//MARK: Design Patterns

import Foundation
import UIKit
import Combine

//MARK: - Creational design patterns
///Object creational mechanisms -> create objects in a manner suitable to the situation.

//MARK: Singleton -> only one instance of the class
class MySingleton {
    static let sharedInstance = MySingleton()
    var number = 0
    private init(){}
}

var singleA = MySingleton.sharedInstance
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance

singleB.number = 2

print(singleA.number)
print(singleB.number)
print(singleC.number)

singleB.number = 3

print(singleA.number)
print(singleB.number)
print(singleC.number)


//MARK: Builder Pattern -> help to reduce the need to keep mutable state / construct complicated objects in an incremental way instead of putting every setting into an initializer

//Burger example
struct BurgerOld {
    var name: String
    var patties: Int
    var bacon, cheese, pickles, ketchup, mustard, lettuce, tomato: Bool
    
    init(name: String, patties: Int, bacon: Bool, cheese: Bool, pickles: Bool, ketchup: Bool, mustard: Bool, lettuce: Bool, tomato: Bool) {
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    }
}

var cheeseBurgerOld = BurgerOld(name: "Hamburger", patties: 1, bacon: false, cheese: true, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)

protocol BurgerBuilder {
    var name: String {get}
    var patties: Int {get}
    var bacon: Bool {get}
    var cheese: Bool {get}
    var pickles: Bool {get}
    var ketchup: Bool {get}
    var mustard: Bool {get}
    var lettuce: Bool {get}
    var tomato: Bool {get}
}

struct BurgerBuilderTemplate {
    var name: String = "Burger"
    
    var patties: Int = 1
    
    var bacon: Bool = false
    
    var cheese: Bool = false
    
    var pickles: Bool = true
    
    var ketchup: Bool = true
    
    var mustard: Bool = true
    
    var lettuce: Bool = false
    
    var tomato: Bool = false
    
    mutating func setPatties(choice: Int) {
        self.patties = choice
    }
    mutating func setBacon(choice: Bool) {
        self.bacon = choice
    }
    mutating func setCheese(choice: Bool) {
        self.cheese = choice
    }
    mutating func setPickle(choice: Bool) {
        self.pickles = choice
    }
    mutating func setKetchup(choice: Bool) {
        self.ketchup = choice
    }
    mutating func setMustard(choice: Bool) {
        self.mustard = choice
    }
    mutating func setLettuce(choice: Bool) {
        self.lettuce = choice
    }
    mutating func setTomato(choice: Bool) {
        self.tomato = choice
    }
    
    func buildBurgerOld(name: String) -> BurgerOld {
        return BurgerOld(name: name, patties: patties, bacon: bacon, cheese: cheese, pickles: pickles, ketchup: ketchup, mustard: mustard, lettuce: lettuce, tomato: tomato)
    }
}
var burgerBuilder = BurgerBuilderTemplate()
burgerBuilder.setCheese(choice: true)
var JonBurger = burgerBuilder.buildBurgerOld(name: "Jon's burger")
 

struct HamBurgerBuilder: BurgerBuilder {
    var name: String = "Burger"
    
    var patties: Int = 1
    
    var bacon: Bool = false
    
    var cheese: Bool = false
    
    var pickles: Bool = true
    
    var ketchup: Bool = true
    
    var mustard: Bool = true
    
    var lettuce: Bool = false
    
    var tomato: Bool = false
}

struct CheeseBurgerBuilder: BurgerBuilder {
    var name: String = "Cheese Burger"
    
    var patties: Int = 1
    
    var bacon: Bool = false
    
    var cheese: Bool = true
    
    var pickles: Bool = true
    
    var ketchup: Bool = true
    
    var mustard: Bool = true
    
    var lettuce: Bool = false
    
    var tomato: Bool = false
}

struct Burger {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    init(builder: BurgerBuilder) {
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
    
    func showBurger() {
        print("\(name):\(patties):\(bacon):\(cheese):\(pickles):\(ketchup):\(mustard):\(lettuce):\(tomato):")
    }
}

var myBurger = Burger(builder: HamBurgerBuilder())
myBurger.showBurger()

var myCheeseBurger = Burger(builder: CheeseBurgerBuilder())
myCheeseBurger.patties = 2
myCheeseBurger.tomato = false
myCheeseBurger.showBurger()



// URL builder
enum Method: String {
    case GET
    case POST
}

struct RequestBaseUrls {
    static let gitHub = "https://api.github.com"
}

struct RequestEndpoints{
    static let searchRepositories = "/search/repositories"
}

class RequestBuilder {
    private(set) var baseURL: URL!
    private(set) var endpoint: String = ""
    private(set) var method: Method = .GET
    private(set) var headers: [String: String] = [:]
    private(set) var parameters: [String: String] = [:]
    
    public func setBaseUrl(_ string: String) {
        baseURL = URL(string: string)!
    }
    public func setEndpoint(_ value: String) {
        endpoint = value
    }
    public func setMethod(_ value: Method) {
        method = value
    }
    public func addHeader(_ key: String, _ value: String) {
        headers[key] = value
    }
    public func addParameter(_ key: String, _ value: String) {
        parameters[key] = value
    }

    public func build() -> URLRequest {
        assert(baseURL != nil)
        let url = baseURL.appendingPathComponent(endpoint)
        var components = URLComponents(string: url.absoluteString)

        components?.queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }

        var urlRequest = URLRequest(url: components!.url!)
        urlRequest.httpMethod = method.rawValue

        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        }

        return urlRequest
    }
}

class TaskBuilder {
    private(set) var request: URLRequest!
    
    public func setRequest(_ request: URLRequest) {
        self.request = request
    }
    
    public func build() -> URLSessionDataTask {
        assert(request != nil)
        return URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            guard let data = data,
                   let response = response as? HTTPURLResponse,
                   (200 ..< 300) ~= response.statusCode,
                   error == nil else {
                       return
               }
               
            if let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any] {
               print(responseObject)
            }
        }
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestBuilder = RequestBuilder()
        requestBuilder.setBaseUrl(RequestBaseUrls.gitHub)
        requestBuilder.setEndpoint(RequestEndpoints.searchRepositories)
        requestBuilder.setMethod(.GET)
        requestBuilder.addHeader("Content-Type", "application/json")
        requestBuilder.addParameter("q", "Builder Design Pattern")
        let request = requestBuilder.build()

        let taskBuilder = TaskBuilder()
        taskBuilder.setRequest(request)
        let task = taskBuilder.build()
        task.resume()
    }
}

//MARK: Factory design pattern ->

protocol TextValidation {
    var regExFindMatchString : String {get}
    var validationMessage: String {get}
}

extension TextValidation {
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    
    func validateString(str: String) -> Bool {
        return str.range(of: regExFindMatchString, options: .regularExpression) == nil && str != ""
    }
    
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression){
            return String(str[newMatch])
        }else{
            return nil
        }
    }
}

class AlphaValidation: TextValidation {
    static let sharedInstance = AlphaValidation()
    private init(){}
    let regExFindMatchString = "[^a-zA-Z]"
    let validationMessage = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidation {
    static let sharedInstance = AlphaNumericValidation()
    private init(){}
    let regExFindMatchString = "[^a-zA-Z0-9]"
    let validationMessage = "Can only contain Alpha numeric characters"
}

class NumericValidation: TextValidation {
    static let sharedInstance = NumericValidation()
    private init(){}
    let regExFindMatchString = "[^0-9]"
    let validationMessage = "Can only create numeric characters"
}

func getValidator(alphaCharacter: Bool, numericCharacters: Bool) -> TextValidation?{
    if (alphaCharacter && numericCharacters) {
        return AlphaNumericValidation.sharedInstance
    }else if (alphaCharacter && !numericCharacters) {
        return AlphaValidation.sharedInstance
    }else if (!alphaCharacter && numericCharacters){
        return NumericValidation.sharedInstance
    }else{
        return nil
    }
}

var str = "asd123"
var validator1 = getValidator(alphaCharacter: true, numericCharacters: false)
print("string validated: \(String(describing: validator1!.validateString(str: str)))")

var validator2 = getValidator(alphaCharacter: true, numericCharacters: true)
print("String validated: \(String(describing: validator2!.validateString(str: str)))")
print(validator1?.getMatchingString(str: str) ?? "nil")
print(validator2?.getMatchingString(str: str) ?? "nil")


//MARK: - Behavioral design pattern
///How objects/class communicates with each other

//MARK: Observer design pattern -> One object observes changes on another object

public class User {
    @Published var name: String
    public init(name: String){
        self.name = name
    }
}
let user = User(name: "khawar")
let publisher = user.$name
var subscriber: AnyCancellable = publisher.sink {
    print("user name is \($0)")
}
user.name = "Khawar Ali"


//Auction example -> Building observer pattern
protocol Bidder {
    var id: Int {get}
    func updated(bid: Float)
}

class Auctioneer {
    var bidders = [Bidder]()
    
    func receivedBid(bid: Float) {
        notifyBidder(bid: bid)
    }
    
    func registerBidder(bidder: Bidder) {
        bidders.append(bidder)
    }
    
    func notifyBidder(bid: Float){
        for bidder in bidders {
            bidder.updated(bid: bid)
        }
    }
    
    func deregisterBidder(bidder: Bidder) {
        if let toRemoveIndex = bidders.enumerated().first(where: {$0.element.id == bidder.id}) {
            bidders.remove(at: toRemoveIndex.offset)
        }
    }
}

class OnlineBidder: Bidder {
    var id: Int
    private var subject: Auctioneer
    
    init(id: Int, subject: Auctioneer) {
        self.id = id
        self.subject = subject
        self.subject.registerBidder(bidder: self)
    }
    
    func updated(bid: Float) {
        print("New bid is \(bid)")
    }
}

class InPersonBidder: Bidder {
    var id: Int
    private var subject: Auctioneer
    
    init(id: Int, subject: Auctioneer) {
        self.id = id
        self.subject = subject
        self.subject.registerBidder(bidder: self)
    }
    
    func updated(bid: Float) {
        print ("Present bid sign which would be greater than> \(bid)")
    }
}

let auctioneer = Auctioneer()
let onlineBidder = OnlineBidder(id: 1, subject: auctioneer)
let inPersonBidder = InPersonBidder(id: 2, subject: auctioneer)
auctioneer.receivedBid(bid: 100.0)

//
  
//MARK: - Structural design pattern
///Class's structure and composition

//MARK: Adapter design pattern


//MARK: Bridge design pattern

//MARK: Decorator design pattern
protocol SwitchOption {
    func turnOn()
    func turnOff()
}

protocol ModeOption {
    func changeMode()
}

protocol FanSpeedOption {
    func controlWindSpeed()
}

class Switch: SwitchOption {
    func turnOn() {
        print("turn on")
    }
    
    func turnOff() {
        print("turn off")
    }
}

class Mode: ModeOption {
    func changeMode() {
        print("mode changed")
    }
}

class FanSpeed: FanSpeedOption {
    func controlWindSpeed() {
        print("Fan speed changed")
    }
}


protocol Cost {
    func price() -> Int
}

protocol ACFeatures: SwitchOption, ModeOption, FanSpeedOption, Cost {
    
}

class FullPriceAirConditioner: ACFeatures {
    let modeController = Mode()
    let fanSpeedController = FanSpeed()
    let switchController = Switch()
    
    
    func turnOn() {
        switchController.turnOn()
    }
    
    func turnOff() {
        switchController.turnOff()
    }
    
    func changeMode() {
        modeController.changeMode()
    }
    
    func controlWindSpeed() {
        fanSpeedController.controlWindSpeed()
    }
    
    func price() -> Int {
        print("Full price")
        return 1000
    }
}

class DiscountedAC: ACFeatures {
    let acProduct: FullPriceAirConditioner
    
    init(ac: FullPriceAirConditioner) {
        acProduct = ac
    }
    
    func turnOn() {
        acProduct.turnOn()
    }
    
    func turnOff() {
        acProduct.turnOff()
    }
    
    func changeMode() {
        acProduct.changeMode()
    }
    
    func controlWindSpeed() {
        acProduct.controlWindSpeed()
    }
    
    func price() -> Int {
        print("Discounted price")
        return Int(Float(acProduct.price()) * 0.75)
    }
}
