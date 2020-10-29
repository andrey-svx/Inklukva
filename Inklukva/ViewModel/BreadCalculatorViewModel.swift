import Foundation
import Combine

final class BreadCalculatorViewModel {
    
    @Published private(set) var breadCalculator: BreadCalculator = BreadCalculator.initial
    
    typealias Preset = HydrationPickerView.Preset
    typealias Recipe = RecipesSlideView.Recipe
    
    private(set) var isWrapped: Bool = true
    
    private(set) var starterHydration: Double = BreadCalculator.initial.starterHydration
    let starterHeader: String = NSLocalizedString("calculator.starter-label", comment: "")
    let starterPresets: [Preset]
    let starterInitialPreset: Preset
    
    private(set) var doughHydration: Double = BreadCalculator.initial.doughHydration
    let doughHeader: String = NSLocalizedString("calculator.dough-label", comment: "")
    let doughPresets: [Preset]
    let doughInitialPreset: Preset
    
    @Published private(set) var flourMass: Double = BreadCalculator.initial.flourMass
    
    @Published private(set) var starterRecipe: Recipe = [
        (NSLocalizedString("calculator.flour-label", comment: ""), BreadCalculator.initial.starter.flour),
        (NSLocalizedString("calculator.water-label", comment: ""), BreadCalculator.initial.starter.water),
        (NSLocalizedString("calculator.inoculate-label", comment: ""), BreadCalculator.initial.starter.inoculate)
    ]
    
    @Published private(set) var doughRecipe: Recipe = [
        (NSLocalizedString("calculator.flour-label", comment: ""), BreadCalculator.initial.dough.flour),
        (NSLocalizedString("calculator.water-label", comment: ""), BreadCalculator.initial.dough.water),
        (NSLocalizedString("calculator.salt-label", comment: ""), BreadCalculator.initial.dough.salt),
        (NSLocalizedString("calculator.starter-label", comment: ""), BreadCalculator.initial.dough.starter)
    ]

    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        let lmString = NSLocalizedString("calculator.levito-madre-starter-label", comment: "") + " (50%)"
        let regularString = NSLocalizedString("calculator.regular-starter-label", comment: "") + " (100%)"
        let starterPresets = [ ("25%", 25), (lmString, 50), ("75%", 75), (regularString, 100), ("125%", 125) ]
        self.starterPresets = starterPresets
        self.starterInitialPreset = starterPresets.first { Double($0.1) == BreadCalculator.initial.starterHydration }
            ?? (regularString, 100)
        
        let doughPresets = stride(from: 50, through: 100, by: 10).compactMap { $0 }
            .map { ("\($0)%", $0) }
        self.doughPresets = doughPresets
        self.doughInitialPreset = doughPresets.first { Double($0.1) == BreadCalculator.initial.doughHydration }
            ?? ("100%", 100)
        
        bind()
        
    }
    
    func bind() {
        self.$breadCalculator
            .sink { [weak self] breadCalculator in
                guard let self = self else { assertionFailure("Could not set self"); return }
                
                self.starterHydration = breadCalculator.starterHydration
                self.doughHydration = breadCalculator.doughHydration
                
                self.flourMass = breadCalculator.flourMass
                
                let starter = breadCalculator.starter
                let starterNames = self.starterRecipe.map { $0.0 }
                let starterAmounts = [starter.flour, starter.water, starter.inoculate]
                self.starterRecipe = zip(starterNames, starterAmounts).compactMap { $0 }
                
                let dough = breadCalculator.dough
                let doughNames = self.doughRecipe.map { $0.0 }
                let doughAmounts = [dough.flour, dough.water, dough.salt, dough.starter]
                self.doughRecipe = zip(doughNames, doughAmounts).compactMap { $0 }
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
