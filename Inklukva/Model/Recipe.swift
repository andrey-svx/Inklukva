import Foundation

struct Recipe {
    
    var flourMass: Double
    var humidity: Double
    
    var starter: Starter {
        let flour = flourMass * 0.2
        let water = flour * humidity
        let inoculate = flour * 0.2
        return Starter(flour: flour, water: water, inoculate: inoculate)
    }
    
    var dough: Dough {
        let flour = flourMass * 0.8
        let water = flourMass * humidity - self.starter.water
        let salt = flourMass * 0.02
        let starter = self.starter.total - self.starter.inoculate
        return Dough(flour: flour, water: water, salt: salt, starter: starter)
    }
    
    static let initial = Recipe(flourMass: 0, humidity: 100)
    
}
