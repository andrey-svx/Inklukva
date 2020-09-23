import Foundation
import UIKit

class PresetView: UIView {
    
    public var title: String
    public var humidity: Double
    public var isChecked: Bool
    
    private let titleLabel: UILabel
    private let checkmarckView: UIImageView
    
    init(title: String, humidity: Double, isChecked: Bool = false) {
        
        self.title = title
        self.humidity = humidity
        self.isChecked = isChecked
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.text = NSLocalizedString(self.title, comment: "")
        
        checkmarckView = UIImageView()
        checkmarckView.image = UIImage(systemName: "checkmark")
        
        super.init(frame: .zero)
        
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, checkmarckView])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
