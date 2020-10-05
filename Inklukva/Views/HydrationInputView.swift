import Foundation
import UIKit

class HydrationInputView: UIView {
    
    public var isWrapped: Bool

    private let headerLabel: UILabel
    private let wrapButton: UIButton
    private let starterInputView: HydrationPickerView
    private let doughInputView: HydrationPickerView
    
    private let tapGestureRecognizer: UITapGestureRecognizer
    
    init() {
        isWrapped = true
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = NSLocalizedString("Select hydraition level", comment: "")
        
        let headerView = UIView(frame: .zero)
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
            
        wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let buttonImage = UIImage(systemName: "chevron.down", withConfiguration: imageConfiguration)
        wrapButton.setImage(buttonImage, for: .normal)
        
        let footerView = UIView(frame: .zero)
        footerView.addSubview(wrapButton)
        wrapButton.pinEndgesToSuperview()
        
        let lmString = NSLocalizedString("Levito-Madre", comment: "") + " (50%)"
        let regularString = NSLocalizedString("Regular", comment: "") + " (100%)"
        let starterPresets = [ ("25%", 25), (lmString, 50), ("75%", 75), (regularString, 100), ("125%", 125) ]
        starterInputView = HydrationPickerView(
            header: NSLocalizedString("Starter", comment: ""),
            presets: starterPresets,
            initialPreset: (regularString, 100),
            isWrapped: self.isWrapped
        )
        
        let doughPresets = stride(from: 50, through: 100, by: 10)
            .compactMap { $0 }
            .map { ("\($0)%", $0) }
        doughInputView = HydrationPickerView(
            header: NSLocalizedString("Dough", comment: ""),
            presets: doughPresets,
            isWrapped: self.isWrapped
        )
        
        let stackView = UIStackView(arrangedSubviews: [headerView, starterInputView, doughInputView, footerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
//        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        stackView.isLayoutMarginsRelativeArrangement = true
        
        tapGestureRecognizer = UITapGestureRecognizer()
        
        super.init(frame: .zero)
        
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
        
        tapGestureRecognizer.addTarget(self, action: #selector(wrap))
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        backgroundColor = .systemGreen
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wrap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.wrapButton.transform = self.isWrapped ? CGAffineTransform(rotationAngle: .pi) : .identity
            for pickerView in [self.starterInputView, self.doughInputView] {
                pickerView.isWrapped = !self.isWrapped
            }
            self.isWrapped.toggle()
        }
    }
    
}

extension HydrationInputView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        isWrapped ? true : false
    }
}
