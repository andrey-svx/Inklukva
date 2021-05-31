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
    
    static func instantiateHeaderView(header: String, forTextStyle: UIFont.TextStyle = .title2) -> UIView {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: forTextStyle)
        headerLabel.text = header
        
        let headerView = UIView(frame: .zero)
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
        
        return headerView
    }
}
