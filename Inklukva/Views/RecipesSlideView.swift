import Foundation
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Ingredients
    
    private let scrollView: UIScrollView
    private let recipeViews: [RecipeView]
    private let pageController: UIPageControl
    
    init(recipes: [Recipe]) {
        
        recipeViews = recipes.map { RecipeView(ingredients: $0) }
        
        let horizontalStack = UIStackView(arrangedSubviews: self.recipeViews)
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.alignment = .top
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        pageController = UIPageControl()
        pageController.numberOfPages = recipeViews.count
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .darkGray
        
        super.init(frame: .zero)
        
        scrollView.delegate = self
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        headerLabel.text = "Take:"
        
        let stackView = UIStackView(arrangedSubviews: [headerLabel, scrollView, pageController])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        
        addSubview(stackView)
        stackView.pinEndgesToSuperview()
        
        recipeViews.forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: widthAnchor)
            ])
        }
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
