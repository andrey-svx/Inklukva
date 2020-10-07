import UIKit

extension UIView {
    @discardableResult func pinEndgesToSuperview(padding: CGFloat = 0.0) -> Bool {
        guard let superview = self.superview else { return false }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
        return true
    }
    
    static func instantiateHeaderView(header: String) -> UIView {
        let headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
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
