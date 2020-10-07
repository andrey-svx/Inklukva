import Foundation

struct BreadCalculator {
    
    public var flourMass: Double
    public var starterHumidity: Double
    public var doughHumidity: Double
    
    public var starter: Starter {
        let flour = flourMass * 0.2
        let water = flour * (starterHumidity / 100)
        let inoculate = flour * 0.2
        return Starter(flour: flour, water: water, inoculate: inoculate)
    }
    
    public var dough: Dough {
        let flour = flourMass * 0.8
        let water = flourMass * (doughHumidity / 100) - self.starter.water
        let salt = flourMass * 0.02
        let starter = self.starter.total - self.starter.inoculate
        return Dough(flour: flour, water: water, salt: salt, starter: starter)
    }
    
    init(flourMass: Double, starterHumidity: Double, doughHumidity: Double) {
        self.flourMass = flourMass
        self.starterHumidity = starterHumidity
        self.doughHumidity = doughHumidity
    }
    
    public static let initial = BreadCalculator(flourMass: 100, starterHumidity: 100, doughHumidity: 100)
    
}
