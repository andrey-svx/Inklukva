import Foundation
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Ingredients
    
    private let scrollView: UIScrollView
    private let starterView: RecipeView
    private let doughView: RecipeView
    private let pageController: UIPageControl
    
    init(starterRecipe: Recipe, doughRecipe: Recipe) {
        
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
        
        super.init(frame: .zero)
        scrollView.delegate = self
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = NSLocalizedString("Here are your ingredients", comment: "")
        
        let headerView = UIView(frame: .zero)
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor)
        ])
        
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
        
        backgroundColor = .systemGreen
        layer.cornerRadius = 10
        
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
