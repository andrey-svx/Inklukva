import Combine
import UIKit

final class FlourInputView: UIView {
    
    private let viewModel: BreadCalculatorViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var massLabel: UILabel = {
        let massLabel = UILabel()
        massLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        massLabel.text = "\(viewModel.flourMass)"
        return massLabel
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 1000
        stepper.stepValue = 10
        stepper.value = viewModel.flourMass
        stepper.addTarget(self, action: #selector(setMass), for: .valueChanged)
        return stepper
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: BreadCalculatorViewModel, header: String) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        let headerLabel = UIView.instantiateHeaderView(header: header)
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel, massLabel, stepper])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        self.viewModel.$flourMass
            .sink { [weak self] value in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.massLabel.text = "\(value)"
            }
            .store(in: &subscriptions)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview(padding: 10)
        
    }
    
    @objc func setMass() {
        self.viewModel.setFlourMass(stepper.value)
    }

}
