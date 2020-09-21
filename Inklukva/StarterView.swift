import Foundation
import UIKit

class StarterView: UIView {

    let stackView: UIStackView
    
    let headerView: UIStackView
    let nameLabel: UILabel
    let wrapButton: UIButton
        
    let detailView: [UIView]
    let plainView: UILabel
    let levitoMadreView: UILabel
    let slider: UISlider
    
    var isWrapped: Bool
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        isWrapped = true
        
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
        slider.value = 75
        slider.isHidden = true
        
        detailView = [plainView, levitoMadreView, slider]
        
        stackView = UIStackView(arrangedSubviews: [headerView] + detailView)
        stackView.axis = .vertical
        
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
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
        _ = detailView.map {
            $0.isHidden = false
            $0.alpha = 1.0
        }
    }

    func wrapUp() {
        wrapButton.transform = .identity
        _ = detailView.map {
            $0.isHidden = true
            $0.alpha = 0.0
        }
    }
        
}
