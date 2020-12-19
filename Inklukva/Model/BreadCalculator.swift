import Foundation

struct BreadCalculator {
    
    public var flourMass: Double
    public var starterHydration: Double
    public var doughHydration: Double
    
    private let starterDoughBalance = 0.2
    
    public var starter: Starter {
        let flour = flourMass * starterDoughBalance
        let water = flour * (starterHydration / 100)
        let inoculate = flour * 0.2
        
        return Starter(flour: flour, water: water, inoculate: inoculate)
    }
    
    public var dough: Dough {
        let flour = flourMass * (1 - starterDoughBalance)
        let water = flourMass * (doughHydration / 100) - self.starter.water
        let salt = flourMass * 0.02
        let starter = self.starter.total - self.starter.inoculate
        
        return Dough(flour: flour, water: water, salt: salt, starter: starter)
    }
    
    init(flourMass: Double, starterHumidity: Double, doughHumidity: Double) {
        self.flourMass = flourMass
        self.starterHydration = starterHumidity
        self.doughHydration = doughHumidity
    }
    
    public static let initial = BreadCalculator(
        flourMass: 0,
        starterHumidity: 100,
        doughHumidity: 100
    )
    
}
