import Combine
import UIKit

final class HydrationPickerView: UIView {
    
    typealias Preset = (String, Int)
    
    @Published var isWrapped: Bool
    private var subscriptions = Set<AnyCancellable>()

    private let header: String
    private let presets: [Preset]
    
    var selectionHandler: ((Int) -> ())?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, pickerView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        return headerLabel
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.isHidden = isWrapped
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    init(header: String, presets: [Preset], initialPreset: Preset, isWrapped: Bool) {
        
        self.header = header
        self.presets = presets
        self.isWrapped = isWrapped
        
        super.init(frame: .zero)
        
        let initialIndex = presets.firstIndex { $0 == initialPreset } ?? 0
        headerLabel.text = header + ": " + presets[initialIndex].0
        
        self.$isWrapped
            .sink { [weak self] value in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.pickerView.isHidden = value
            }
            .store(in: &subscriptions)
        
        pickerView.selectRow(initialIndex, inComponent: 0, animated: false)
        
        addSubview(stackView)
        stackView.pinEdgesToSuperview()
        
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 4/5)
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
