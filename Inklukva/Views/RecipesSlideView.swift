import Foundation
import UIKit

final class RecipesSlideView: UIView {
    
    typealias Recipe = RecipeView.Ingredients
    
    private let scrollView: UIScrollView
    private let recipeViews: [RecipeView]
    private let pageController: UIPageControl
    
    init(recipes: [Recipe]) {
        
        recipeViews = recipes.map { RecipeView(ingredients: $0) }
        
        let stackView = UIStackView(arrangedSubviews: self.recipeViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        
        scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pinEndgesToSuperview()
        scrollView.addSubview(stackView)
        
        stackView.pinEndgesToSuperview()
        
        pageController = UIPageControl()
        pageController.numberOfPages = recipeViews.count
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = .lightGray
        pageController.currentPageIndicatorTintColor = .darkGray
        
        super.init(frame: .zero)
        
        scrollView.delegate = self
        addSubview(scrollView)
        addSubview(pageController)
        
        scrollView.pinEndgesToSuperview()
        pageController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageController.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageController.centerYAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
        recipeViews.forEach { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: widthAnchor),
                view.heightAnchor.constraint(equalTo: heightAnchor)
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
