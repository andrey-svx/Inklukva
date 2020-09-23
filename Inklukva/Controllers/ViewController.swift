import UIKit

class ViewController: UIViewController {
    
    var breadCalculator: BreadCalculator
    
    let inoculateInputView: HumidityInputView
    let flourInputView: FlourInputView
    let recipesSlideView: RecipesSlideView
    
    init(breadCalculator: BreadCalculator) {
        
        self.breadCalculator = breadCalculator
        let presets: [HumidityInputView.Preset] = [
            ("Plain", 100),
            ("Levito-Madre", 50)
        ]
        inoculateInputView = HumidityInputView(header: "Starter", humidity: Float(breadCalculator.starterHumidity), presets: presets)
        flourInputView = FlourInputView(mass: breadCalculator.flourMass)
        let starter = self.breadCalculator.starter
        let dough = self.breadCalculator.dough
        let starterRecipe: RecipesSlideView.Recipe = [
            ("Flour", starter.flour),
            ("Water", starter.water),
            ("Inoculate", starter.inoculate)
        ]
        let doughRecipe: RecipesSlideView.Recipe = [
            ("Flour", dough.flour),
            ("Water", dough.water),
            ("Salt", dough.salt),
            ("Starter", dough.starter)
        ]
        let recipes = [starterRecipe, doughRecipe]
        recipesSlideView = RecipesSlideView(recipes: recipes)
        
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inoculateInputView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(inoculateInputView)
        view.addSubview(flourInputView)
        view.addSubview(recipesSlideView)
        
        recipesSlideView.translatesAutoresizingMaskIntoConstraints = false
        inoculateInputView.translatesAutoresizingMaskIntoConstraints = false
        flourInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inoculateInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inoculateInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 10),
            inoculateInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            
            flourInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flourInputView.topAnchor.constraint(equalTo: inoculateInputView.bottomAnchor, constant: view.frame.height / 20),
            
            recipesSlideView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipesSlideView.topAnchor.constraint(equalTo: flourInputView.bottomAnchor, constant: view.frame.height / 10),
            recipesSlideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            recipesSlideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}

extension ViewController: HumidityInputViewDelegate {
    
    func setValue(humidity: Float) {
        self.breadCalculator.starterHumidity = Double(humidity)
    }
    
}
