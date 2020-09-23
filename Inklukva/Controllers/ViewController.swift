import UIKit

class ViewController: UIViewController {
    
    let recipe: Recipe
    
    let starterInputView: StarterInputView
    let flourInputView: FlourInputView
    let recipesSlideView: RecipesSlideView
    
    init(recipe: Recipe) {
        
        self.recipe = recipe
        
        starterInputView = StarterInputView(humidity: Float(recipe.humidity))
        flourInputView = FlourInputView(mass: recipe.flourMass)
        let starter = self.recipe.starter
        let dough = self.recipe.dough

//        recipesSlideView = RecipesSlideView(ingredientsList: ingredientsList)
        
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starterInputView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(starterInputView)
        view.addSubview(flourInputView)
        view.addSubview(recipesSlideView)
        
        recipesSlideView.translatesAutoresizingMaskIntoConstraints = false
        starterInputView.translatesAutoresizingMaskIntoConstraints = false
        flourInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starterInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starterInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 10),
            starterInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            
            flourInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flourInputView.topAnchor.constraint(equalTo: starterInputView.bottomAnchor, constant: view.frame.height / 20),
            
            recipesSlideView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipesSlideView.topAnchor.constraint(equalTo: flourInputView.bottomAnchor, constant: view.frame.height / 10),
            recipesSlideView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            recipesSlideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
}

extension ViewController: StarterInputViewDelegate {
    
    func setValue(humidity: Float) {
        
    }
    
}
