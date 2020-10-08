import Foundation
import Combine

final class BreadCalculatorViewModel {
    
    @Published private(set) var breadCalculator: BreadCalculator
    
    typealias Preset = HydrationPickerView.Preset
    typealias Recipe = RecipesSlideView.Recipe
    
    private(set) var isWrapped: Bool = true
    
    private(set) var starterHydration: Double = BreadCalculator.initial.starterHydration
    public let starterHeader: String = NSLocalizedString("Starter", comment: "")
    public let starterPresets: [Preset]
    public let starterInitialPreset: Preset
    
    private(set) var doughHydration: Double = BreadCalculator.initial.doughHydration
    public let doughHeader: String = NSLocalizedString("Dough", comment: "")
    public let doughPresets: [Preset]
    public let doughInitialPreset: Preset
    
    @Published private(set) var flourMass: Double = BreadCalculator.initial.flourMass
    
    @Published private(set) var starterRecipe: Recipe = [
        (NSLocalizedString("Flour", comment: ""), BreadCalculator.initial.starter.flour),
        (NSLocalizedString("Water", comment: ""), BreadCalculator.initial.starter.water),
        (NSLocalizedString("Inoculate", comment: ""), BreadCalculator.initial.starter.inoculate)
    ]
    
    @Published private(set) var doughRecipe: Recipe = [
        (NSLocalizedString("Flour", comment: ""), BreadCalculator.initial.dough.flour),
        (NSLocalizedString("Water", comment: ""), BreadCalculator.initial.dough.water),
        (NSLocalizedString("Salt", comment: ""), BreadCalculator.initial.dough.salt),
        (NSLocalizedString("Starter", comment: ""), BreadCalculator.initial.dough.starter)
    ]

    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        let flourMass = BreadCalculator.initial.flourMass
        let starterHumidity = BreadCalculator.initial.starterHydration
        let doughHumidity = BreadCalculator.initial.doughHydration
        self.breadCalculator = BreadCalculator(
            flourMass: flourMass,
            starterHumidity: starterHumidity,
            doughHumidity: doughHumidity
        )
        
        let lmString = NSLocalizedString("Levito-Madre", comment: "") + " (50%)"
        let regularString = NSLocalizedString("Regular", comment: "") + " (100%)"
        let starterPresets = [ ("25%", 25), (lmString, 50), ("75%", 75), (regularString, 100), ("125%", 125) ]
        self.starterPresets = starterPresets
        self.starterInitialPreset = starterPresets.first { Double($0.1) == BreadCalculator.initial.starterHydration }
            ?? (regularString, 100)
        
        let doughPresets = stride(from: 50, through: 100, by: 10)
            .compactMap { $0 }
            .map { ("\($0)%", $0) }
        self.doughPresets = doughPresets
        self.doughInitialPreset = doughPresets.first { Double($0.1) == BreadCalculator.initial.doughHydration }
            ?? ("100%", 100)
        
        self.$breadCalculator
            .sink { [weak self] breadCalculator in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.flourMass = breadCalculator.flourMass
                
                self.starterHydration = breadCalculator.starterHydration
                self.doughHydration = breadCalculator.doughHydration
                
                let starter = breadCalculator.starter
                for (i, value) in [starter.flour, starter.water, starter.inoculate].enumerated() {
                    self.starterRecipe[i].1 = value
                }
                
                let dough = breadCalculator.dough
                for (i, value) in [dough.flour, dough.water, dough.salt, dough.starter].enumerated() {
                    self.doughRecipe[i].1 = value
                }
            }
            .store(in: &subscriptions)
        
    }
    
}

extension BreadCalculatorViewModel {
    
    public func wrap() {
        isWrapped.toggle()
    }
    
    public func setStarterHydration(_ hydration: Double) {
        breadCalculator.starterHydration = hydration
    }
    
    public func setDoughHydration(_ hydration: Double) {
        breadCalculator.doughHydration = hydration
    }
    
    public func setFlourMass(_ mass: Double) {
        breadCalculator.flourMass = mass
    }
    
}
