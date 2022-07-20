// MARK: Decorator design pattern

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

protocol ACFeatures: SwitchOption, ModeOption, FanSpeedOption, Cost {}

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
