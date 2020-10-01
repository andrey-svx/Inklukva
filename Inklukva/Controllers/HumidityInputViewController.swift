import UIKit

final class HumidityInputViewController: UIViewController {
    
    public var isWrapped: Bool
    
    private let starterViewController: PickerViewController
    private let doughViewController: PickerViewController

    private let headerLabel: UILabel
    private let wrapButton: UIButton
    private let starterInputView: UIView
    private let doughInputView: UIView
    
    init() {
        isWrapped = true
        
        headerLabel = UILabel()
        headerLabel.text = "Properties"
            
        wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        wrapButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        
        let starterPresets = [
            ("25%", 25), ("Levito-Madre (50%)", 50), ("75%", 75), ("Regular(100%)", 100), ("125%", 125)
        ]
        starterViewController = PickerViewController(header: "Starter", presets: starterPresets, isWrapped: isWrapped)
        starterInputView = starterViewController.view
        
        let doughPresets = stride(from: 50, through: 100, by: 10)
            .compactMap { $0 }
            .map { ("\($0)%", $0) }
        doughViewController = PickerViewController(header: "Dough", presets: doughPresets, isWrapped: isWrapped)
        doughInputView = doughViewController.view
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(starterViewController)
        didMove(toParent: starterViewController)
        
        addChild(doughViewController)
        didMove(toParent: doughViewController)
        
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wrapButton.translatesAutoresizingMaskIntoConstraints = false
        
        let headerStack = UIStackView(arrangedSubviews: [headerLabel, wrapButton])
        headerStack.axis = .horizontal
        headerStack.distribution = .fill
        headerStack.alignment = .center
        headerStack.spacing = 0
        
        let stackView = UIStackView(arrangedSubviews: [headerStack, starterInputView, doughInputView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        view.addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        view.layer.borderColor = UIColor.systemBlue.cgColor
        view.layer.borderWidth = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NSLayoutConstraint.activate([
            wrapButton.widthAnchor.constraint(equalTo: wrapButton.heightAnchor)
        ])
    }
    
    @objc func wrap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.isWrapped ? self.unwrap() : self.wrapUp()
            self.isWrapped.toggle()
        }
    }
    
    func unwrap() {
        wrapButton.transform = CGAffineTransform(rotationAngle: .pi * 3/4)
        for viewController in [starterViewController, doughViewController] {
            viewController.isWrapped = !self.isWrapped
        }
    }

    func wrapUp() {
        wrapButton.transform = .identity
        for viewController in [starterViewController, doughViewController] {
            viewController.isWrapped = !self.isWrapped
        }
    }

}
