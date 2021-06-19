import Combine
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Recipe
    
    @Published private var stepNumber: Int = 0
    
    private let viewModel: BreadCalculatorViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var starterView: RecipeView = {
        let starterView = RecipeView(header: viewModel.starterHeader, ingredients: viewModel.starterRecipe)
        starterView.translatesAutoresizingMaskIntoConstraints = false
        return starterView
    }()
    
    private lazy var doughView: RecipeView = {
        let doughView = RecipeView(header: viewModel.doughHeader, ingredients: viewModel.doughRecipe)
        doughView.translatesAutoresizingMaskIntoConstraints = false
        doughView.setNeedsLayout()
        doughView.layoutIfNeeded()
        return doughView
    }()
    
    private lazy var stepLabel: UILabel = {
        let stepLabel = UILabel()
        stepLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        stepLabel.textAlignment = .center
        return stepLabel
    }()
    
    private lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.numberOfPages = 2
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .darkGray
        pageController.isUserInteractionEnabled = false
        pageController.currentPage = self.stepNumber
        return pageController
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let horizontalStack = UIStackView(arrangedSubviews: [starterView, doughView])
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.alignment = .top
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStack
    }()
    
    init(viewModel: BreadCalculatorViewModel, header: String) {
        
        self.viewModel = viewModel
        super.init(frame: .zero)

        scrollView.addSubview(horizontalStack)
        addSubview(scrollView)
        
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
        
        let headerView = UILabel()
        headerView.textAlignment = .center
        headerView.font = UIFont.preferredFont(forTextStyle: .title2)
        headerView.adjustsFontSizeToFitWidth = true
        headerView.minimumScaleFactor = 0.5
        headerView.text = header
        
        let stackView = UIStackView(arrangedSubviews: [headerView, scrollView, stepLabel, pageController])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: doughView.frame.height),
            
            starterView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            doughView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20)
        ])
        stackView.pinEdgesToSuperview(padding: 10)
        
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
