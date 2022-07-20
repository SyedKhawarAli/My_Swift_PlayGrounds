import Foundation
import UIKit

// MARK: - Builder Pattern -> help to reduce the need to keep mutable state / construct complicated objects in an incremental way instead of putting every setting into an initializer

// Burger example
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
    var name: String { get }
    var patties: Int { get }
    var bacon: Bool { get }
    var cheese: Bool { get }
    var pickles: Bool { get }
    var ketchup: Bool { get }
    var mustard: Bool { get }
    var lettuce: Bool { get }
    var tomato: Bool { get }
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
        patties = choice
    }

    mutating func setBacon(choice: Bool) {
        bacon = choice
    }

    mutating func setCheese(choice: Bool) {
        cheese = choice
    }

    mutating func setPickle(choice: Bool) {
        pickles = choice
    }

    mutating func setKetchup(choice: Bool) {
        ketchup = choice
    }

    mutating func setMustard(choice: Bool) {
        mustard = choice
    }

    mutating func setLettuce(choice: Bool) {
        lettuce = choice
    }

    mutating func setTomato(choice: Bool) {
        tomato = choice
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
        name = builder.name
        patties = builder.patties
        bacon = builder.bacon
        cheese = builder.cheese
        pickles = builder.pickles
        ketchup = builder.ketchup
        mustard = builder.mustard
        lettuce = builder.lettuce
        tomato = builder.tomato
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

enum RequestBaseUrls {
    static let gitHub = "https://api.github.com"
}

enum RequestEndpoints {
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
            data, response, error in

            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  (200 ..< 300) ~= response.statusCode,
                  error == nil
            else {
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
