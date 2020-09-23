import Foundation
import UIKit

protocol HumidityInputViewDelegate: class {
    
    func setValue(humidity: Float)
    
}

final class HumidityInputView: UIView {
    
    typealias Preset = (String, Double)
    
    weak var delegate: HumidityInputViewDelegate?
    
    public var header: String
    public var presets: [Preset]
    private(set) var humidity: Float
    private var isWrapped: Bool = true
    
    private let headerLabel: UILabel
    private let wrapButton: UIButton
        
    private let detailViews: [UIView]
    private let presetViews: [PresetView]
    private let slider: UISlider
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(header: String, humidity: Float, presets: [Preset]) {
        
        self.header = header
        self.presets = presets
        self.humidity = humidity
        
        headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        headerLabel.text = NSLocalizedString(self.header, comment: "")
        
        wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultLow, for: .vertical)
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        wrapButton.setImage(UIImage(systemName: "plus"), for: .normal)
        
        let headerView = UIStackView(arrangedSubviews: [headerLabel, wrapButton])
        headerView.axis = .horizontal
        headerView.alignment = .fill
        headerView.distribution = .fill
        
        presetViews = self.presets.map { PresetView(title: $0.0, humidity: $0.1) }
        
        slider = UISlider()
        slider.minimumValue = 50
        slider.maximumValue = 125
        slider.value = self.humidity
        slider.isHidden = true
        
        detailViews = presetViews + [slider]
        
        let stackView = UIStackView(arrangedSubviews: [headerView] + detailViews)
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
        for view in detailViews {
            view.isHidden = false
            view.alpha = 1.0
        }
    }

    func wrapUp() {
        wrapButton.transform = .identity
        for view in detailViews {
            view.isHidden = true
            view.alpha = 0.0
        }
    }
    
    @objc func setHumidity() {
        guard let delegate = self.delegate else {
            assertionFailure("Did not set up delegate!")
            return
        }
        humidity = slider.value
        delegate.setValue(humidity: humidity)
    }
        
}
