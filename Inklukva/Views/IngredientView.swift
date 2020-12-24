import UIKit

final class IngredientView: UIView {
    
    typealias Ingredient = (String, Double)
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return nameLabel
    }()
    
    lazy var amountLabel: UILabel = {
        let amountLabel = UILabel()
        amountLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        return amountLabel
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, amountLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    init(ingredient: Ingredient) {
        super.init(frame: .zero)
        nameLabel.text = ingredient.0
        amountLabel.text = String(format: "%.1f", ingredient.1)
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
