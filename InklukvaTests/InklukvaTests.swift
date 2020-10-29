import XCTest
@testable import Inklukva

class InklukvaTests: XCTestCase {

    var breadCalculator = BreadCalculator.initial
    
    func test_initial_masses() {
        XCTAssertEqual(breadCalculator.starter.total, 0)
        XCTAssertEqual(breadCalculator.dough.total, 0)
        
        breadCalculator.flourMass = 350
        breadCalculator.starterHydration = 125
        breadCalculator.doughHydration = 70
    }
    
    func test_starter_ingredients() {
        breadCalculator.flourMass = 350
        breadCalculator.starterHydration = 125
        breadCalculator.doughHydration = 70
        
        XCTAssertEqual(breadCalculator.starter.flour, 70, accuracy: 1.0)
        XCTAssertEqual(breadCalculator.starter.water, 87.5, accuracy: 1.0)
        XCTAssertEqual(breadCalculator.starter.inoculate, 14, accuracy: 1.0)
    }
    
    func test_dough_ingredients() {
        breadCalculator.flourMass = 350
        breadCalculator.starterHydration = 125
        breadCalculator.doughHydration = 70
        
        XCTAssertEqual(breadCalculator.dough.flour, 280, accuracy: 1.0)
        XCTAssertEqual(breadCalculator.dough.water, 157.5, accuracy: 1.0)
        XCTAssertEqual(breadCalculator.dough.salt, 7, accuracy: 1.0)
        XCTAssertEqual(breadCalculator.dough.starter, 157.5, accuracy: 1.0)
    }
    
}
