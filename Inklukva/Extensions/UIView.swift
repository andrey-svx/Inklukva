import UIKit

extension UIView {
    
    @discardableResult
    func pinEdgesToSuperview(padding: CGFloat = 0.0) -> Bool {
        guard let superview = superview else { return false }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
        return true
    }
}
