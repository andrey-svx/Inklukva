import Foundation
import UIKit

final class IngredientView: UIView {
    
    public let nameLabel: UILabel
    public let amountLabel: UILabel
    
    init(name: String, amount: Double) {
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = name
        
        amountLabel = UILabel()
        amountLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        amountLabel.text = "\(amount)"
        
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
