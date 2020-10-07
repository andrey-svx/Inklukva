import Combine
import Foundation

final class BreadCalculatorViewModel {
    
    @Published public var breadCalculator: BreadCalculator
    private var subscriptions = Set<AnyCancellable>()
    
    public var flourMass: Double = 0
    
    init() {
        self.breadCalculator = BreadCalculator.initial
        $breadCalculator.sink { [weak self] breadCalculator in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.flourMass = breadCalculator.flourMass
        }
        .store(in: &subscriptions)
    }
    
    public func setFlourMass(mass: Double) {
        breadCalculator.flourMass = mass
    }
    
}
