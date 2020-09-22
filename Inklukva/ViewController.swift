import UIKit

class ViewController: UIViewController {
    
    let recipe = Recipe(flour: 100, humidity: 100)
    
    let starterInputView = StarterInputView()
    let flourInputView = FlourInputView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(starterInputView)
        view.addSubview(flourInputView)
        
        var ingredients: RecipeView.Ingredients = [:]
        ingredients["Flour"] = 100
        ingredients["Water"] = 100
        ingredients["Salt"] = 100
        let ingredientsList = [ingredients, ingredients, ingredients]
        
        let recipesSlideView = RecipesSlideView(ingredientsList: ingredientsList)
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
