import Foundation
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = (String, Double)
    typealias Ingredients = [Ingredient]
    
    let header: String
    var ingredients: [Ingredient]
    
    private let headerLabel: UILabel
    private let ingredientViews: [IngredientView]
    public let stackView: UIStackView
    
    required init(header: String, ingredients: Ingredients) {
        
        self.header = header
        self.ingredients = ingredients
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = header
        
        ingredientViews = ingredients.map { IngredientView(name: $0.0, amount: Double($0.1)) }
        
        stackView = UIStackView(arrangedSubviews: [headerLabel] + ingredientViews)
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

