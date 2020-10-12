import Combine
import UIKit

final class IngredientView: UIView {
    
    typealias Ingredient = (String, Double)
    
//    @Published var ingredient: Ingredient
    private var subscriptions = Set<AnyCancellable>()
    
    let nameLabel: UILabel
    let amountLabel: UILabel
    
    init(ingredient: Ingredient) {
        
//        self.ingredient = ingredient
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = ingredient.0
        
        amountLabel = UILabel()
        amountLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        amountLabel.text = "\(ingredient.1)"
        
        super.init(frame: .zero)
//        self.$ingredient
//            .sink { [weak self] value in
//                guard let self = self else { assertionFailure("Could not set self"); return }
//                self.nameLabel.text = "\(value.0)"
//                self.amountLabel.text = "\(value.1)"
//            }
//        .store(in: &subscriptions)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, amountLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
