import Combine
import UIKit

final class BreadCalculatorViewController: UIViewController {
    
    private let viewModel: BreadCalculatorViewModel
    
    private let flourInputView: FlourInputView
    private let recipesSlideView: RecipesSlideView
    private let hydrationInputView: UIView
    
    private let stackView: UIStackView
    private let scrollView: UIScrollView
    
    init(viewModel: BreadCalculatorViewModel) {
        
        self.viewModel = viewModel
        
        hydrationInputView = HydrationInputView(viewModel: viewModel)
        flourInputView = FlourInputView(viewModel: viewModel)
        recipesSlideView = RecipesSlideView(viewModel: viewModel)
        
        stackView = UIStackView(arrangedSubviews: [hydrationInputView, flourInputView, recipesSlideView])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20

        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.arrangedSubviews.forEach {
            $0.backgroundColor = .systemGreen
            $0.layer.cornerRadius = 10
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stackView.pinEndgesToSuperview()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
