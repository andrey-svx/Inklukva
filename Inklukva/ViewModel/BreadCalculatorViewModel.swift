import Combine
import Foundation

final class BreadCalculatorViewModel {
    
    @Published public var breadCalculator: BreadCalculator
    
    
    
    init() {
        self.breadCalculator = BreadCalculator.initial
    }
    
}
