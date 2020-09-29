import UIKit

class PickerViewController: UIViewController {
    
    typealias Preset = (String, Int)
    
    let header: String
    let presets: [Preset]
    var isWrapped: Bool {
        didSet {
            pickerView.isHidden = isWrapped
        }
    }
    
    let stackView: UIStackView
    let headerLabel: UILabel
    let pickerView: UIPickerView
    
    init(header: String, presets: [Preset]) {
        self.header = header
        self.presets = presets
        self.isWrapped = false
        
        headerLabel = UILabel()
        headerLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        pickerView = UIPickerView()
        stackView = UIStackView(arrangedSubviews: [headerLabel, pickerView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 0
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        headerLabel.text = header
        pickerView.dataSource = self
        pickerView.delegate = self
        view.addSubview(stackView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stackView.pinEndgesToSuperview()
        
    }

}

extension PickerViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presets.count
    }
    
}

extension PickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presets[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        headerLabel.text = presets[row].0
    }
    
}
