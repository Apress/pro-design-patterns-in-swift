import Foundation

class Product : NSObject, NSCopying {
    
    fileprivate(set) var name:String;
    fileprivate(set) var productDescription:String;
    fileprivate(set) var category:String;
    fileprivate var stockLevelBackingValue:Int = 0;
    fileprivate var priceBackingValue:Double = 0;
    
    init(name:String, description:String, category:String, price:Double,
        stockLevel:Int) {
            self.name = name;
            self.productDescription = description;
            self.category = category;
            
            super.init();
            
            self.price = price;
            self.stockLevel = stockLevel;
    }
    
    var stockLevel:Int {
        get { return stockLevelBackingValue;}
        set { stockLevelBackingValue = max(0, newValue);}
    }
    
    fileprivate(set) var price:Double {
        get { return priceBackingValue;}
        set { priceBackingValue = max(1, newValue);}
    }
    
    var stockValue:Double {
        get {
            return price * Double(stockLevel);
        }
    }
    
    func copy(with zone: NSZone?) -> Any {
        return Product(name: self.name, description: self.description,
            category: self.category, price: self.price,
            stockLevel: self.stockLevel);
    }
}
