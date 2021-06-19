import UIKit

final class HydrationInputView: UIView {
    
    private let viewModel: BreadCalculatorViewModel

    private lazy var wrapButton: UIButton = {
        let wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let buttonImage = UIImage(systemName: "chevron.down", withConfiguration: imageConfiguration)
        wrapButton.setImage(buttonImage, for: .normal)
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
        return wrapButton
    }()
    
    private lazy var starterInputView: HydrationPickerView = {
        let starterInputView = HydrationPickerView(
            header: viewModel.starterHeader,
            presets: viewModel.starterPresets,
            initialPreset: viewModel.starterInitialPreset,
            isWrapped: viewModel.isWrapped
        )
        starterInputView.selectionHandler = { [weak self] hydration in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.viewModel.setStarterHydration(Double(hydration))
        }
        return starterInputView
    }()
    
    private lazy var doughInputView: HydrationPickerView = {
        let doughInputView = HydrationPickerView(
            header: viewModel.doughHeader,
            presets: viewModel.doughPresets,
            initialPreset: viewModel.doughInitialPreset,
            isWrapped: viewModel.isWrapped
        )
        doughInputView.selectionHandler = { [weak self] hydration in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.viewModel.setDoughHydration(Double(hydration))
        }
        return doughInputView
    }()
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(wrap))
        tapGestureRecognizer.delegate = self
        return tapGestureRecognizer
    }()
    
    init(viewModel: BreadCalculatorViewModel, header: String) {
                
        self.viewModel = viewModel
        super.init(frame: .zero)

        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont.preferredFont(forTextStyle: .title2)
        headerView.adjustsFontSizeToFitWidth = true
        headerView.minimumScaleFactor = 0.5
        headerView.text = header
        
        let footerView = UIView(frame: .zero)
        footerView.addSubview(wrapButton)
        wrapButton.pinEdgesToSuperview()

        let stackView = UIStackView(arrangedSubviews: [headerView, starterInputView, doughInputView, footerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5

        addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(stackView)
        stackView.pinEdgesToSuperview(padding: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wrap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.wrapButton.transform = self.viewModel.isWrapped
                ? CGAffineTransform(rotationAngle: .pi)
                : .identity
            [self.starterInputView, self.doughInputView].forEach { $0.isWrapped = !self.viewModel.isWrapped }
            self.viewModel.wrap()
        }
    }
    
}

extension HydrationInputView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        viewModel.isWrapped
            ? true
            : false
    }
    
}
