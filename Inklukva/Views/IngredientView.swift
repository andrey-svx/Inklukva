import Combine
import UIKit

final class IngredientView: UIView {
    
    public let name: String
    
    @Published public var amount: Double
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let nameLabel: UILabel
    private let amountLabel: UILabel
    
    init(name: String, amount: Double) {
        
        self.name = name
        self.amount = amount
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = name
        
        amountLabel = UILabel()
        amountLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        amountLabel.text = "\(amount)"
        
        super.init(frame: .zero)
        $amount.sink { [weak self] value in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.amountLabel.text = "\(self.amount)"
        }
        .store(in: &subscriptions)
        
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
