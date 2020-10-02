import Foundation
import UIKit

class HydratationPickerView: UIView {
    
    typealias Preset = (String, Int)
    
    public let header: String
    public let presets: [Preset]
    
    var isWrapped: Bool {
        didSet {
            pickerView.isHidden = isWrapped
            layoutIfNeeded()
        }
    }
    
    private let stackView: UIStackView
    private let headerLabel: UILabel
    private let pickerView: UIPickerView
    
    init(header: String, presets: [Preset], initialPreset: Preset, isWrapped: Bool) {
        self.header = header
        self.presets = presets
        self.isWrapped = isWrapped
        
        headerLabel = UILabel()
        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        headerLabel.text = header
        
        pickerView = UIPickerView()
        pickerView.isHidden = isWrapped
        
        stackView = UIStackView(arrangedSubviews: [headerLabel, pickerView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HydratationPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presets.count
    }
    
}

extension HydratationPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presets[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        headerLabel.text = header + ": " + presets[row].0
    }
    
}
