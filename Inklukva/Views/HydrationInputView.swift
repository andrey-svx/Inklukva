import Combine
import Foundation
import UIKit

final class HydrationInputView: UIView {
    
    private let viewModel: BreadCalculatorViewModel
    
    private var subscriptions = Set<AnyCancellable>()

    private let wrapButton: UIButton
    private let starterInputView: HydrationPickerView
    private let doughInputView: HydrationPickerView
    
    private let tapGestureRecognizer: UITapGestureRecognizer
    
    init(viewModel: BreadCalculatorViewModel) {
                
        self.viewModel = viewModel
        
        let headerView = UIView.instantiateHeaderView(header: NSLocalizedString("Select hydration level", comment: ""))
            
        wrapButton = UIButton()
        wrapButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let buttonImage = UIImage(systemName: "chevron.down", withConfiguration: imageConfiguration)
        wrapButton.setImage(buttonImage, for: .normal)
        
        let footerView = UIView(frame: .zero)
        footerView.addSubview(wrapButton)
        wrapButton.pinEndgesToSuperview()
        
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
        
        let stackView = UIStackView(arrangedSubviews: [headerView, starterInputView, doughInputView, footerView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        tapGestureRecognizer = UITapGestureRecognizer()
        
        super.init(frame: .zero)
        
        wrapButton.addTarget(self, action: #selector(wrap), for: .touchUpInside)
        
        tapGestureRecognizer.addTarget(self, action: #selector(wrap))
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func wrap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self = self else { assertionFailure("Could not set self"); return }
            self.wrapButton.transform = self.viewModel.isWrapped ? CGAffineTransform(rotationAngle: .pi) : .identity
            for pickerView in [self.starterInputView, self.doughInputView] {
                pickerView.isWrapped = !self.viewModel.isWrapped
            }
            self.viewModel.isWrapped.toggle()
        }
    }
    
}

extension HydrationInputView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        viewModel.isWrapped ? true : false
    }
}
