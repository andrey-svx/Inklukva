import Combine
import Foundation

final class BreadCalculatorViewModel {
    
    @Published private(set) var breadCalculator: BreadCalculator
    
    @Published public var flourMass: Double
    @Published public var starterHumidity: Double
    @Published public var doughHumidity: Double

    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        self.flourMass = BreadCalculator.initial.flourMass
        self.starterHumidity = BreadCalculator.initial.starterHumidity
        self.doughHumidity = BreadCalculator.initial.doughHumidity
        
        let flourMass = BreadCalculator.initial.flourMass
        let starterHumidity = BreadCalculator.initial.starterHumidity
        let doughHumidity = BreadCalculator.initial.doughHumidity
        self.breadCalculator = BreadCalculator(
            flourMass: flourMass,
            starterHumidity: starterHumidity,
            doughHumidity: doughHumidity
        )
        self.$breadCalculator.sink { [weak self] breadCalculator in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.flourMass = breadCalculator.flourMass
            self.starterHumidity = breadCalculator.starterHumidity
            self.doughHumidity = breadCalculator.doughHumidity
        }
        .store(in: &subscriptions)
        
    }
    
    public func setFlourMass(mass: Double) {
        breadCalculator.flourMass = mass
    }
    
}
