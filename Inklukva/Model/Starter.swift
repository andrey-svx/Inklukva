import Foundation

struct Starter {
    
    var flour: Double
    var water: Double
    var inoculate: Double
    
    var total: Double {
        return inoculate + flour + water
    }

}
