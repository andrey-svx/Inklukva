import UIKit

class MainViewController: UIViewController {
    
    var breadCalculator: BreadCalculator
    
    let flourInputView: FlourInputView
    let recipesSlideView: RecipesSlideView
    let starterPickerView: UIView
    
    init(breadCalculator: BreadCalculator) {
        
        self.breadCalculator = breadCalculator

        let starterPresets = [
            ("25%", 25), ("Левито-Мадре (50%)", 50), ("75%", 75), ("Обычная (100%)", 100), ("125%", 125)
        ]
        let pickerVC = PickerViewController(header: "Starter", presets: starterPresets)
        starterPickerView = pickerVC.view
        
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
    
        addChild(pickerVC)
        pickerVC.didMove(toParent: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(starterPickerView)
        view.addSubview(flourInputView)
        view.addSubview(recipesSlideView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starterPickerView.translatesAutoresizingMaskIntoConstraints = false
        recipesSlideView.translatesAutoresizingMaskIntoConstraints = false
        flourInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starterPickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            starterPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starterPickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            starterPickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            
            flourInputView.topAnchor.constraint(equalTo: starterPickerView.bottomAnchor),
            flourInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flourInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            flourInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20),
            
            recipesSlideView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipesSlideView.topAnchor.constraint(equalTo: flourInputView.bottomAnchor, constant: view.frame.height / 10),
            recipesSlideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            recipesSlideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}
