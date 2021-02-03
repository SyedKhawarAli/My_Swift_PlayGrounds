import Foundation
import UIKit
//MARK: Design Patterns


//MARK: - Singleton -> only one instance of the class
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


//MARK: - Builder Pattern -> help to reduce the need to keep mutable state / construct complicated objects in an incremental way instead of putting every setting into an initializer

//MARK: Burger

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



//MARK: URL builder
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

//MARK: - Factory design pattern ->

  
