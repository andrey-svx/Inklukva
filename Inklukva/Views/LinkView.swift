import UIKit

class LinkView: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("inklukva.ru", for: .normal)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        addSubview(button)
        button.pinEdgesToSuperview(padding: 5.0)
    }
    
    @objc func openLink() {
        guard let url = URL(string: "https://inklukva.ru") else { return }
        UIApplication.shared.open(url)
    }
    
    
}
