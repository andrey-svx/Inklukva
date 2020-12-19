import Combine
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Recipe
    
    @Published private var stepNumber: Int
    
    private let viewModel: BreadCalculatorViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private let scrollView: UIScrollView
    private let starterView: RecipeView
    private let doughView: RecipeView
    private var stepLabel: UILabel
    private let pageController: UIPageControl
    
    init(viewModel: BreadCalculatorViewModel, header: String) {
        
        self.viewModel = viewModel
        
        starterView = RecipeView(header: viewModel.starterHeader, ingredients: viewModel.starterRecipe)
        starterView.translatesAutoresizingMaskIntoConstraints = false
        
        doughView = RecipeView(header: viewModel.doughHeader, ingredients: viewModel.doughRecipe)
        doughView.translatesAutoresizingMaskIntoConstraints = false
        doughView.setNeedsLayout()
        doughView.layoutIfNeeded()
        
        let horizontalStack = UIStackView(arrangedSubviews: [starterView, doughView])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.alignment = .top
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(horizontalStack)

        self.stepNumber = 0
        
        stepLabel = UILabel()
        stepLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        stepLabel.textAlignment = .center
        
        pageController = UIPageControl()
        pageController.numberOfPages = 2
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .darkGray
        pageController.isUserInteractionEnabled = false

        super.init(frame: .zero)

        pageController.currentPage = self.stepNumber
        
        self.viewModel.$starterRecipe
            .sink { [weak self] starterRecipe in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.starterView.ingredients = starterRecipe
            }
            .store(in: &subscriptions)
        
        self.viewModel.$doughRecipe
            .sink { [weak self] doughRecipe in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.doughView.ingredients = doughRecipe
            }
            .store(in: &subscriptions)
        
        self.$stepNumber
            .sink { [weak self] stepNumber in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.pageController.currentPage = stepNumber
                let stepHeader = NSLocalizedString("calculator.step-number-title", comment: "")
                    + " \(self.pageController.currentPage + 1)"
                self.stepLabel.text = stepHeader
            }
            .store(in: &subscriptions)
        
        scrollView.delegate = self
        
        let headerView = UIView.instantiateHeaderView(header: header)
        
        let stackView = UIStackView(arrangedSubviews: [headerView, scrollView, stepLabel, pageController])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let doughHeight = doughView.frame.height
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: doughHeight),
            
            starterView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            doughView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
        stackView.pinEndgesToSuperview(padding: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RecipesSlideView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let relativeOffset = scrollView.contentOffset.x / frame.width
        stepNumber = Int(round(relativeOffset))
    }
}
