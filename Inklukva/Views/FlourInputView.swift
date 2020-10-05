import Foundation
import UIKit

final class FlourInputView: UIView {
    
    private let flourLabel: UILabel
    private let stepper: UIStepper
    
    private(set) var mass: Double {
        didSet {
            flourLabel.text = "\(mass)"
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(mass: Double) {
        
        self.mass = mass
        
        flourLabel = UILabel()
        flourLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        flourLabel.text = "\(mass)"
        
        stepper = UIStepper()
        stepper.minimumValue = 0
        stepper.maximumValue = 1000
        stepper.stepValue = 50
        stepper.value = self.mass
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = NSLocalizedString("Set flour wheight", comment: "")
        
        let headerView = UIView(frame: .zero)
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel, flourLabel, stepper])
        stackView.axis = .vertical
        stackView.alignment = .center
            
        super.init(frame: .zero)
        
        stepper.addTarget(self, action: #selector(setMass), for: .valueChanged)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        backgroundColor = .systemGreen
        layer.cornerRadius = 10
        
    }
    
    @objc func setMass() {
        mass = stepper.value
    }

}
