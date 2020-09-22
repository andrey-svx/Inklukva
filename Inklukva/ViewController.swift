import UIKit

class ViewController: UIViewController {
    
    let starterInputView = StarterInputView()
    let flourInputView = FlourInputView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(starterInputView)
        view.addSubview(flourInputView)
        
        starterInputView.translatesAutoresizingMaskIntoConstraints = false
        flourInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starterInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starterInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 10),
            starterInputView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4),
            
            flourInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flourInputView.topAnchor.constraint(equalTo: starterInputView.bottomAnchor, constant: view.frame.height / 20)
        ])
    }
}
