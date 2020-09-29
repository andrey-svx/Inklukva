import UIKit

class PickerViewController: UIViewController {
    
    typealias Preset = (String, Int)
    
    let header: String
    let presets: [Preset]
    var isWrapped: Bool
    
    let headerLabel: UILabel
    let pickerView: UIPickerView
    
    init(header: String, presets: [Preset]) {
        self.header = header
        self.presets = presets
        self.isWrapped = true
        
        headerLabel = UILabel()
        pickerView = UIPickerView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = header
        pickerView.dataSource = self
        pickerView.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [headerLabel, pickerView])
        stackView.axis = .vertical
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
}
