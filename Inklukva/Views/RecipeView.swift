import Foundation
import UIKit

class RecipeView: UIView {
    
    typealias Ingredients = [String: Double]

    let ingredientViews: [IngredientView]
    
    required init(ingredients: Ingredients) {
        
        ingredientViews = ingredients.map { name, amount in
            return IngredientView(name: name, amount: amount)
        }
        let stackView = UIStackView(arrangedSubviews: ingredientViews)
        stackView.axis = .vertical
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

