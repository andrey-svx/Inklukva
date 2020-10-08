import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Recipe
    
    public var starterRecipe: Recipe
    public var doughRecipe: Recipe
    
    private let scrollView: UIScrollView
    private let starterView: RecipeView
    private let doughView: RecipeView
    private let pageController: UIPageControl
    
    init(starterRecipe: Recipe, doughRecipe: Recipe) {
        
        self.starterRecipe = starterRecipe
        self.doughRecipe = doughRecipe
        
        starterView = RecipeView(
            header: NSLocalizedString("Starter", comment: ""),
            ingredients: starterRecipe
        )
        starterView.translatesAutoresizingMaskIntoConstraints = false
        
        doughView = RecipeView(
            header: NSLocalizedString("Dough", comment: ""),
            ingredients: doughRecipe
        )
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
