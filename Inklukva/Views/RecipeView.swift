import Combine
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = IngredientView.Ingredient
    typealias Recipe = [Ingredient]
    
    public let header: String
    
    @Published public var ingredients: [Ingredient]
    private var subscriptions = Set<AnyCancellable>()
    
    private let headerLabel: UILabel
    private let ingredientViews: [IngredientView]
    
    required init(header: String, ingredients: Recipe) {
        
        self.header = header
        self.ingredients = ingredients
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = header
        
        ingredientViews = ingredients.map { IngredientView(ingredient: $0) }
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel] + ingredientViews)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        self.$ingredients.sink { [weak self] ingredients in
            guard let self = self else { assertionFailure("Could not set self"); return }
            for var (i, view) in self.ingredientViews.enumerated() {
                view.ingredient = ingredients[i]
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

