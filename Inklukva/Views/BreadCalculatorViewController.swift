import UIKit

final class BreadCalculatorViewController: UIViewController {
    
    private let viewModel: BreadCalculatorViewModel
    
    private lazy var hydrationInputView: HydrationInputView = {
        let hydrationInputView = HydrationInputView(
            viewModel: viewModel,
            header: NSLocalizedString("calculator.hydration-title", comment: "")
        )
        return hydrationInputView
    }()
    
    private lazy var flourInputView: FlourInputView = {
        let flourInputView = FlourInputView(
            viewModel: viewModel,
            header: NSLocalizedString("calculator.wheight-title", comment: "")
        )
        return flourInputView
    }()
    
    private lazy var recipesSlideView: RecipesSlideView = {
        let recipesSlideView = RecipesSlideView(
            viewModel: viewModel,
            header: NSLocalizedString("calculator.ingredients-title", comment: "")
        )
        return recipesSlideView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [hydrationInputView, flourInputView, recipesSlideView, linkView])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let linkView = LinkView()
    
    init(viewModel: BreadCalculatorViewModel) {
        self.viewModel = viewModel
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
            $0.layer.borderColor = UIColor.systemGreen.cgColor
            $0.layer.borderWidth = 0
            $0.backgroundColor = UIColor(red: 187/256, green: 183/256, blue: 164/256, alpha: 1.0)
            $0.layer.cornerRadius = 7.5
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
