import UIKit

final class MainViewController: UIViewController {
    
    private var breadCalculator: BreadCalculator
    
    private let flourInputView: FlourInputView
    private let recipesSlideView: RecipesSlideView
    private let hydratationInputView: UIView
    
    private let stackView: UIStackView
    private let scrollView: UIScrollView
    
    init(breadCalculator: BreadCalculator) {
        
        self.breadCalculator = breadCalculator
        
        hydratationInputView = HydratationInputView()
        
        flourInputView = FlourInputView(mass: breadCalculator.flourMass)
        
        let starter = self.breadCalculator.starter
        let dough = self.breadCalculator.dough
        let starterRecipe: RecipesSlideView.Recipe = [
            ("Flour", starter.flour),
            ("Water", starter.water),
            ("Inoculate", starter.inoculate)
        ]
        let doughRecipe: RecipesSlideView.Recipe = [
            ("Flour", dough.flour),
            ("Water", dough.water),
            ("Salt", dough.salt),
            ("Starter", dough.starter)
        ]
        let recipes = [starterRecipe, doughRecipe]
        recipesSlideView = RecipesSlideView(recipes: recipes)
        
        stackView = UIStackView(arrangedSubviews: [hydratationInputView, flourInputView, recipesSlideView])
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stackView.pinEndgesToSuperview()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipesSlideView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
