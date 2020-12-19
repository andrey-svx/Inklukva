import UIKit

class LinkView: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("inklukva.ru", for: .normal)
        button.addTarget(self, action: #selector(gotoLink), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        addSubview(button)
        button.pinEndgesToSuperview(padding: 5.0)
    }
    
    @objc func gotoLink() {
        guard let url = URL(string: "https://inklukva.ru") else { return }
        UIApplication.shared.open(url)
    }
    
    
}
