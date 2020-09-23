import Foundation
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = (String, Double)
    typealias Ingredients = [Ingredient]

    let ingredientViews: [IngredientView]
    
    required init(ingredients: Ingredients) {
        
        ingredientViews = ingredients.map { IngredientView(name: $0.0, amount: Double($0.1)) }
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
        
//        stackView.layer.borderColor = UIColor.systemBlue.cgColor
//        stackView.layer.borderWidth = 1.0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

