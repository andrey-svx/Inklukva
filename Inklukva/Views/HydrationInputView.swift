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
    
    private let starterInputView: HydrationPickerView
    private let doughInputView: HydrationPickerView
    
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(wrap))
        tapGestureRecognizer.delegate = self
        return tapGestureRecognizer
    }()
    
    init(viewModel: BreadCalculatorViewModel, header: String) {
                
        self.viewModel = viewModel
        
        let headerView = UIView.instantiateHeaderView(header: header)
        
        starterInputView = HydrationPickerView(
            header: viewModel.starterHeader,
            presets: viewModel.starterPresets,
            initialPreset: viewModel.starterInitialPreset,
            isWrapped: viewModel.isWrapped
        )
        
        doughInputView = HydrationPickerView(
            header: viewModel.doughHeader,
            presets: viewModel.doughPresets,
            initialPreset: viewModel.doughInitialPreset,
            isWrapped: viewModel.isWrapped
        )
        
        let footerView = UIView(frame: .zero)

        let stackView = UIStackView(arrangedSubviews: [headerView, starterInputView, doughInputView, footerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        super.init(frame: .zero)
        
        footerView.addSubview(wrapButton)
        wrapButton.pinEndgesToSuperview()
        
        starterInputView.selectionHandler = { [weak self] hydration in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.viewModel.setStarterHydration(Double(hydration))
        }
        doughInputView.selectionHandler = { [weak self] hydration in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.viewModel.setDoughHydration(Double(hydration))
        }

        addGestureRecognizer(tapGestureRecognizer)
        addSubview(stackView)
        stackView.pinEndgesToSuperview(padding: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wrap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.wrapButton.transform = self.viewModel.isWrapped ? CGAffineTransform(rotationAngle: .pi) : .identity
            [self.starterInputView, self.doughInputView].forEach { $0.isWrapped = !self.viewModel.isWrapped }
            self.viewModel.wrap()
        }
    }
    
}

extension HydrationInputView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        viewModel.isWrapped ? true : false
    }
}
