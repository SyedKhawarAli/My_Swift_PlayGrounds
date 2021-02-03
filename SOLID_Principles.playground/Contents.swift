
import UIKit

//MARK: - SOLID principle

//Single responsibility principle
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

class AirConditionerNew: SwitchOption, ModeOption, FanSpeedOption {
    
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
}

//MARK: - Open close principle
protocol HumidAble {
    func changeHumidity(_ value: Int)
}

class HumidityController: HumidAble {
    func changeHumidity(_ value: Int) {
        print("you have changed air humidity to \(value)")
    }
}

extension AirConditionerNew: HumidAble {
    func changeHumidity(_ value: Int) {
        let humidController = HumidityController()
        humidController.changeHumidity(value)
    }
}

let acNew = AirConditionerNew()
acNew.changeHumidity(10)

//MARK: - Liskov's Substitution principle

//Decorator design pattern
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

//MARK: - Interface segregation

protocol CentralizedFeature {
    func getCentralizedACCount() -> Int
}

class CentralizedAC: ACFeatures, CentralizedFeature {
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
        return 5000
    }
    
    func getCentralizedACCount() -> Int {
        print("get centralized")
        return 5
    }
    
}

class SplitAC: ACFeatures {
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
        return 1000
    }
}


//MARK: - Dependency Inversion - high level module should not depend on the low level module
protocol Database {
    func saveToDatabase(conversations: [Any])
}

class ConversationalDataController {
    let database : Database //making database independent of database type e.g Core data
    
    init(inDatabase: Database) {
        database = inDatabase
    }
    
    func getAllConversations(){
        let conversations = [Any]()
        database.saveToDatabase(conversations: conversations)
    }
}

class CoreDataController: Database {
    func saveToDatabase(conversations: [Any]) {
        //save to database
    }
}
