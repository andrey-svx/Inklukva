import Foundation
import UIKit

class StarterView: UIView {
    
    let nameLabel: UILabel
    let wrapButton: UIButton
        
    var plainView: UILabel
    var levitoMadreView: UILabel
    var slider: UISlider
    let detailView: [UIView]

    let stackView: UIStackView
    
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
        
        let headerView = UIStackView(arrangedSubviews: [nameLabel, wrapButton])
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
        UIView.animate(withDuration: 0.25) {
            self.isWrapped ? self.unwrap() : self.wrapUp()
            self.layoutIfNeeded()
            self.isWrapped.toggle()
        }
    }
    
    func unwrap() {
        wrapButton.transform = CGAffineTransform(rotationAngle: .pi/4)
        _ = detailView.map({ $0.isHidden = false })
    }

    func wrapUp() {
        wrapButton.transform = .identity
        _ = detailView.map({ $0.isHidden = true })
    }
        
}
