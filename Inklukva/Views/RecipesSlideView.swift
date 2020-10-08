import Combine
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Recipe
    
    private let viewModel: BreadCalculatorViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private let scrollView: UIScrollView
    private let starterView: RecipeView
    private let doughView: RecipeView
    private let pageController: UIPageControl
    
    init(viewModel: BreadCalculatorViewModel) {
        
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
        
        pageController = UIPageControl()
        pageController.numberOfPages = 2
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .darkGray
        pageController.isUserInteractionEnabled = false
        
        super.init(frame: .zero)
        
        self.viewModel
            .$starterRecipe.sink { [weak self] starterRecipe in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.starterView.ingredients = starterRecipe
            }
            .store(in: &subscriptions)
        
        self.viewModel
            .$doughRecipe.sink { [weak self] doughRecipe in
                guard let self = self else { assertionFailure("Could not set self"); return }
                self.doughView.ingredients = doughRecipe
            }
            .store(in: &subscriptions)
        
        scrollView.delegate = self
        
        let headerView = UIView.instantiateHeaderView(header: NSLocalizedString("Here are your ingredients", comment: ""))
        
        let stackView = UIStackView(arrangedSubviews: [headerView, scrollView, pageController])
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
            
            starterView.widthAnchor.constraint(equalTo: widthAnchor),
            doughView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        stackView.pinEndgesToSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RecipesSlideView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let relativeOffset = scrollView.contentOffset.x / frame.width
        let pageNumber = Int(round(relativeOffset))
        pageController.currentPage = pageNumber
    }
}
