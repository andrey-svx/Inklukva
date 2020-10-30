import UIKit

extension UIView {
    @discardableResult func pinEndgesToSuperview(padding: CGFloat = 0.0) -> Bool {
        guard let superview = self.superview else { return false }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding)
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
