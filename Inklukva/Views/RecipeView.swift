import Foundation
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = (String, Double)
    typealias Ingredients = [Ingredient]

    private let ingredientViews: [IngredientView]
    
    required init(ingredients: Ingredients) {
        
        ingredientViews = ingredients.map { IngredientView(name: $0.0, amount: Double($0.1)) }
        
        let stackView = UIStackView(arrangedSubviews: ingredientViews)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

