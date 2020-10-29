import Combine
import UIKit

final class IngredientView: UIView {
    
    typealias Ingredient = (String, Double)
    
    private var subscriptions = Set<AnyCancellable>()
    
    let nameLabel: UILabel
    let amountLabel: UILabel
    
    init(ingredient: Ingredient) {
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = ingredient.0
        
        amountLabel = UILabel()
        amountLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        amountLabel.text = String(format: "%.1f", ingredient.1)
        
        super.init(frame: .zero)
        
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
