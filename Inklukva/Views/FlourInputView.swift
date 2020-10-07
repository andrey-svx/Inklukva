import Combine
import Foundation
import UIKit

final class FlourInputView: UIView {
    
    private let massLabel: UILabel
    private let stepper: UIStepper
    
    private var viewModel: BreadCalculatorViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: BreadCalculatorViewModel) {
        
        self.viewModel = viewModel
        let mass = viewModel.flourMass
        
        massLabel = UILabel()
        massLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        massLabel.text = "\(mass)"
        
        stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 1000
        stepper.stepValue = 50
        stepper.value = mass
        
        let headerLabel = UIView.instantiateHeaderView(header: NSLocalizedString("Set flour wheight", comment: ""))
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel, massLabel, stepper])
        stackView.axis = .vertical
        stackView.alignment = .center
            
        super.init(frame: .zero)
        
        stepper.addTarget(self, action: #selector(setMass), for: .valueChanged)
        
        self.viewModel
            .$flourMass
            .sink { [weak self] value in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.massLabel.text = "\(value)"
            }
            .store(in: &subscriptions)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
    }
    
    @objc func setMass() {
        self.viewModel.setFlourMass(mass: stepper.value)
    }

}
