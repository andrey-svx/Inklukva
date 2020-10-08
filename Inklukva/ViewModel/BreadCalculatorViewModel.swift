import Foundation
import Combine

final class BreadCalculatorViewModel {
    
    @Published private(set) var breadCalculator: BreadCalculator
    
    typealias Preset = HydrationPickerView.Preset
    typealias Recipe = RecipesSlideView
    
    private(set) var isWrapped: Bool = true
    
    private(set) var starterHydration: Double = BreadCalculator.initial.starterHydration
    public let starterHeader: String = NSLocalizedString("Starter", comment: "")
    public let starterPresets: [Preset]
    public let starterInitialPreset: Preset
    
    private(set) var doughHydration: Double = BreadCalculator.initial.doughHydration
    public let doughHeader: String = NSLocalizedString("Dough", comment: "")
    public let doughPresets: [Preset]
    public let doughInitialPreset: Preset
    
    @Published public var flourMass: Double = BreadCalculator.initial.flourMass
    
//    @Published public var starterRecipe: RecipesSlideView.Recipe
//    @Published public var doughRecipe: RecipesSlideView.Recipe

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
        self.starterInitialPreset = (regularString, 100)
        self.starterPresets = [ ("25%", 25), (lmString, 50), ("75%", 75), (regularString, 100), ("125%", 125) ]
        
        self.doughPresets = stride(from: 50, through: 100, by: 10)
            .compactMap { $0 }
            .map { ("\($0)%", $0) }
        self.doughInitialPreset = ("100%", 100)
        
        self.$breadCalculator
            .sink { [weak self] breadCalculator in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.flourMass = breadCalculator.flourMass
                self.starterHydration = breadCalculator.starterHydration
                self.doughHydration = breadCalculator.doughHydration
            }
            .store(in: &subscriptions)
        
    }
    
    private func saveModel() {
        
    }
    
    private func loadModel() -> BreadCalculator? {
        return BreadCalculator.initial
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
