import Combine
import UIKit

final class HydrationPickerView: UIView {
    
    typealias Preset = (String, Int)
    
    private let header: String
    private let presets: [Preset]
    
    public var selectionHandler: ((Int) -> ())?
    
    @Published public var isWrapped: Bool
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let stackView: UIStackView
    private let headerLabel: UILabel
    private let pickerView: UIPickerView
    
    init(header: String, presets: [Preset], initialPreset: Preset = ("0%", 0), isWrapped: Bool) {
        
        self.header = header
        self.presets = presets
        
        let initialIndex = presets.firstIndex { $0 == initialPreset } ?? 0
        
        self.isWrapped = isWrapped
        
        headerLabel = UILabel()
        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        headerLabel.text = header + ": " + presets[initialIndex].0
        
        pickerView = UIPickerView()
        pickerView.isHidden = isWrapped
        
        stackView = UIStackView(arrangedSubviews: [headerLabel, pickerView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        
        super.init(frame: .zero)
        
        $isWrapped.sink { [weak self] value in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.pickerView.isHidden = value
        }
        .store(in: &subscriptions)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        pickerView.selectRow(initialIndex, inComponent: 0, animated: false)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 3/4)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HydrationPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presets.count
    }
    
}

extension HydrationPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presets[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        headerLabel.text = header + ": " + presets[row].0
        guard let selectionHandler = selectionHandler else { assertionFailure("Handler has not been set"); return }
        selectionHandler(presets[row].1)
    }
    
}
