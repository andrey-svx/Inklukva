import Combine
import Foundation

final class BreadCalculatorViewModel {
    
    @Published private(set) var breadCalculator: BreadCalculator
    
    typealias Preset = (String, Int)
    
    @Published public var isWrapped: Bool
    
    @Published public var starterHumidity: Double
    public let starterHeader: String
    public let starterPresets: [Preset]
    public let starterInitialPreset: Preset
    
    @Published public var doughHumidity: Double
    public let doughHeader: String
    public let doughPresets: [Preset]
    public let doughInitialPreset: Preset
    
    @Published public var flourMass: Double

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

        self.isWrapped = true
        
        self.starterHeader = NSLocalizedString("Starter", comment: "")
        let lmString = NSLocalizedString("Levito-Madre", comment: "") + " (50%)"
        let regularString = NSLocalizedString("Regular", comment: "") + " (100%)"
        self.starterInitialPreset = (regularString, 100)
        self.starterPresets = [ ("25%", 25), (lmString, 50), ("75%", 75), (regularString, 100), ("125%", 125) ]
        
        self.doughHeader = NSLocalizedString("Dough", comment: "")
        self.doughPresets = stride(from: 50, through: 100, by: 10)
            .compactMap { $0 }
            .map { ("\($0)%", $0) }
        self.doughInitialPreset = ("100%", 100)
        
        self.$breadCalculator
            .sink { [weak self] breadCalculator in
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
    
    public func wrap() {
        isWrapped.toggle()
    }
    
}
