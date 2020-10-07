struct Dough {
    
    public var flour: Double
    public var water: Double
    public var salt: Double
    public var starter: Double
    
    public var total: Double {
        return flour + water + salt + starter
    }
    
}
