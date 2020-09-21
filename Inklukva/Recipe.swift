import Foundation

struct Recipe {
    
    var flour: Double
    var humidity: Double
    
    var starter: Starter {
        return Starter(inoculate: 0, flour: 0, water: 0)
    }
    
    var dough: Dough {
        return Dough(starter: starter.sum, flour: 0, water: 0, salt: 0)
    }
    
}

struct Starter {
    
    var inoculate: Double
    var flour: Double
    var water: Double
    
    var sum: Double {
        return inoculate + flour + water
    }

}

struct Dough {
    
    var starter: Double
    var flour: Double
    var water: Double
    var salt: Double
    
}
