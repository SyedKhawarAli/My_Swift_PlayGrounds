import Foundation

// MARK: Factory design pattern ->

protocol TextValidation {
    var regExFindMatchString: String { get }
    var validationMessage: String { get }
}

extension TextValidation {
    var regExMatchingString: String {
        return regExFindMatchString + "$"
    }

    func validateString(str: String) -> Bool {
        return str.range(of: regExFindMatchString, options: .regularExpression) == nil && str != ""
    }

    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return String(str[newMatch])
        } else {
            return nil
        }
    }
}

class AlphaValidation: TextValidation {
    static let sharedInstance = AlphaValidation()
    private init() {}
    let regExFindMatchString = "[^a-zA-Z]"
    let validationMessage = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidation {
    static let sharedInstance = AlphaNumericValidation()
    private init() {}
    let regExFindMatchString = "[^a-zA-Z0-9]"
    let validationMessage = "Can only contain Alpha numeric characters"
}

class NumericValidation: TextValidation {
    static let sharedInstance = NumericValidation()
    private init() {}
    let regExFindMatchString = "[^0-9]"
    let validationMessage = "Can only create numeric characters"
}

func getValidator(alphaCharacter: Bool, numericCharacters: Bool) -> TextValidation? {
    if alphaCharacter, numericCharacters {
        return AlphaNumericValidation.sharedInstance
    } else if alphaCharacter, !numericCharacters {
        return AlphaValidation.sharedInstance
    } else if !alphaCharacter, numericCharacters {
        return NumericValidation.sharedInstance
    } else {
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


// Auction example -> Building observer pattern
protocol Bidder {
    var id: Int { get }
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

    func notifyBidder(bid: Float) {
        for bidder in bidders {
            bidder.updated(bid: bid)
        }
    }

    func deregisterBidder(bidder: Bidder) {
        if let toRemoveIndex = bidders.enumerated().first(where: { $0.element.id == bidder.id }) {
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
        print("Present bid sign which would be greater than> \(bid)")
    }
}

let auctioneer = Auctioneer()
let onlineBidder = OnlineBidder(id: 1, subject: auctioneer)
let inPersonBidder = InPersonBidder(id: 2, subject: auctioneer)
auctioneer.receivedBid(bid: 100.0)
