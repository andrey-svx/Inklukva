import UIKit

extension UIView {
    
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
