import UIKit

class MainViewController: UIViewController {
    
    var breadCalculator: BreadCalculator
    
    let flourInputView: FlourInputView
    let recipesSlideView: RecipesSlideView
    
    init(breadCalculator: BreadCalculator) {
        
        self.breadCalculator = breadCalculator

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
        view.backgroundColor = .white
        view.addSubview(flourInputView)
        view.addSubview(recipesSlideView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesSlideView.translatesAutoresizingMaskIntoConstraints = false
        flourInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flourInputView.topAnchor.constraint(equalTo: view.topAnchor),
            flourInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flourInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            flourInputView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            recipesSlideView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipesSlideView.topAnchor.constraint(equalTo: flourInputView.bottomAnchor, constant: view.frame.height / 10),
            recipesSlideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            recipesSlideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
    }
}
