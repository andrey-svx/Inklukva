import Foundation
import UIKit

protocol InoculateInputViewDelegate: class {
    
    func setValue(humidity: Float)
    
}

final class InoculateInputView: UIView {
    
    weak var delegate: InoculateInputViewDelegate?
    
    private let nameLabel: UILabel
    private let wrapButton: UIButton
        
    private let detailView: [UIView]
    private let plainView: UILabel
    private let levitoMadreView: UILabel
    private let slider: UISlider
    
    private var isWrapped: Bool = true
    
    private(set) var bakingHumidity: Float
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(humidity: Float) {
        
        bakingHumidity = humidity
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        nameLabel.text = NSLocalizedString("Starter:", comment: "")
        
        wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultLow, for: .vertical)
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        wrapButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        let headerView = UIStackView(arrangedSubviews: [nameLabel, wrapButton])
        headerView.axis = .horizontal
        headerView.alignment = .fill
        headerView.distribution = .fill

        plainView = UILabel()
        plainView.text = NSLocalizedString("Plain", comment: "")
        plainView.isHidden = true
        
        levitoMadreView = UILabel()
        levitoMadreView.text = NSLocalizedString("Levito-Madre", comment: "")
        levitoMadreView.isHidden = true
        
        slider = UISlider()
        slider.minimumValue = 50
        slider.maximumValue = 125
        slider.value = self.bakingHumidity
        slider.isHidden = true
        
        detailView = [plainView, levitoMadreView, slider]
        
        let stackView = UIStackView(arrangedSubviews: [headerView] + detailView)
        stackView.axis = .vertical
        stackView.spacing = 5.0
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview(padding: 10.0)
        
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1.0
        
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
        guard let delegate = self.delegate else {
            assertionFailure("Did not set up delegate!")
            return
        }
        bakingHumidity = slider.value
        delegate.setValue(humidity: bakingHumidity)
    }
        
}
