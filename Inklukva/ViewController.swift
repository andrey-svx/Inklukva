import UIKit

class ViewController: UIViewController {
    
    let starterView = StarterInputView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(starterView)
        starterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starterView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 15),
            starterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4)
        ])
    }
}
