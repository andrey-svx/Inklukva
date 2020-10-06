import Combine
import Foundation
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = (String, Double)
    
    public let header: String
    @Published public var ingredients: [Ingredient]
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let headerLabel: UILabel
    private let ingredientViews: [IngredientView]
    public let stackView: UIStackView
    
    required init(header: String, ingredients: [Ingredient]) {
        
        self.header = header
        self.ingredients = ingredients
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = self.header
        
        ingredientViews = ingredients.map { IngredientView(name: $0.0, amount: Double($0.1)) }
        
        stackView = UIStackView(arrangedSubviews: [headerLabel] + ingredientViews)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        $ingredients.sink { [weak self] ingredients in
            guard let self = self else { assertionFailure("Could not set self"); return }
            for var (i, view) in self.ingredientViews.enumerated() {
                view.amount = ingredients[i].1
            }
        }
        .store(in: &subscriptions)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

