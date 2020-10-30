import Combine
import Foundation

class RecipeViewModel {
    @Published var ingredients: [(String, Double)]
    
    init(ingredients: [(String, Double)]) {
        self.ingredients = ingredients
    }
}
