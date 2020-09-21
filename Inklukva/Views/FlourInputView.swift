import Foundation
import UIKit

class FlourInputView: UIView {
    
    let stackView: UIStackView
    
    let flourLabel: UILabel
    let stepper: UIStepper
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
    }

}
