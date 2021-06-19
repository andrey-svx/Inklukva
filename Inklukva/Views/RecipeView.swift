import Combine
import UIKit

final class RecipeView: UIView {
    
    typealias Ingredient = IngredientView.Ingredient
    typealias Recipe = [Ingredient]
    
    @Published var ingredients: [Ingredient]
    private var subscriptions = Set<AnyCancellable>()
    
    private let ingredientViews: [IngredientView]
    
    init(header: String, ingredients: Recipe) {
        
        self.ingredients = ingredients
        
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont.preferredFont(forTextStyle: .title2)
        headerView.adjustsFontSizeToFitWidth = true
        headerView.minimumScaleFactor = 0.5
        headerView.text = header

        ingredientViews = ingredients.map { IngredientView(ingredient: $0) }
        
        let stackView = UIStackView(arrangedSubviews: [headerView] + ingredientViews)
        stackView.axis = .vertical
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        self.$ingredients
            .sink { [weak self] ingredients in
                guard let self = self else { assertionFailure("Could not set self"); return }
                zip(self.ingredientViews, ingredients).compactMap { $0 }
                    .forEach {
                        $0.nameLabel.text = $1.0
                        $0.amountLabel.text = String(format: "%.1f", $1.1)
                    }
            }
            .store(in: &subscriptions)
        
        addSubview(stackView)
        stackView.pinEdgesToSuperview()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

