import Foundation
import UIKit

class StarterInputView: UIView {

    private let stackView: UIStackView
    
    private let headerView: UIStackView
    private let nameLabel: UILabel
    private let wrapButton: UIButton
        
    private let detailView: [UIView]
    private let plainView: UILabel
    private let levitoMadreView: UILabel
    private let slider: UISlider
    
    private var isWrapped: Bool = true
    
    public var bakingHumidity: Float
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        
        bakingHumidity = 75
        
        nameLabel = UILabel()
        nameLabel.text = NSLocalizedString("Starter:", comment: "")
        
        wrapButton = UIButton()
        wrapButton.setImage(UIImage(systemName: "plus"), for: .normal)
        wrapButton.setContentHuggingPriority(.required, for: .horizontal)
        
        headerView = UIStackView(arrangedSubviews: [nameLabel, wrapButton])
        headerView.axis = .horizontal
        headerView.alignment = .firstBaseline
        headerView.distribution = .fillProportionally
        
        plainView = UILabel()
        plainView.text = NSLocalizedString("Plain", comment: "")
        plainView.isHidden = true
        
        levitoMadreView = UILabel()
        levitoMadreView.text = NSLocalizedString("Levito-Madre", comment: "")
        levitoMadreView.isHidden = true
        
        slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 150
        slider.value = bakingHumidity
        slider.isHidden = true
        
        detailView = [plainView, levitoMadreView, slider]
        
        stackView = UIStackView(arrangedSubviews: [headerView] + detailView)
        stackView.axis = .vertical
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
        slider.addTarget(self, action: #selector(setHumidity), for: .valueChanged)
        
    }
    
    @objc func wrap() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.isWrapped ? self.unwrap() : self.wrapUp()
            self.layoutIfNeeded()
            self.isWrapped.toggle()
        }
    }
    
    func unwrap() {
        wrapButton.transform = CGAffineTransform(rotationAngle: .pi * 3/4)
        for view in detailView {
            view.isHidden = false
            view.alpha = 1.0
        }
    }

    func wrapUp() {
        wrapButton.transform = .identity
        for view in detailView {
            view.isHidden = true
            view.alpha = 0.0
        }
    }
    
    @objc func setHumidity() {
        bakingHumidity = slider.value
    }
        
}
