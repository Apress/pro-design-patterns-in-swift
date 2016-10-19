import Foundation

final class ProductDataStore {
    var callback:((Product) -> Void)?;
    private var networkQ:dispatch_queue_t
    private var uiQ:dispatch_queue_t;
    lazy var products:[Product] = self.loadData();
    
    init() {
        networkQ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        uiQ = dispatch_get_main_queue();
    }
    
    private func loadData() -> [Product] {
        
        var products = [Product]();
        
        for product in productData {
            var p:Product = LowStockIncreaseDecorator(product: product);
            if (p.category == "Soccer") {
                p = SoccerDecreaseDecorator(product: p);
            }
            
            dispatch_async(self.networkQ, {() in
                StockServerFactory.getStockServer().getStockLevel(p.name,
                    callback: { name, stockLevel in
                        p.stockLevel = stockLevel;
                        dispatch_async(self.uiQ, {() in
                            if (self.callback != nil) {
                                self.callback!(p);
                            }
                        })
                });
            });
            products.append(p);
        }
        return products;
    }
    
    private var productData:[Product] = [
        ProductComposite(name: "Running Pack",
            description: "Complete Running Outfit", category: "Running",
            stockLevel: 10, products:
            Product.createProduct("Shirt", description: "Running Shirt",
                category: "Running", price: 42, stockLevel: 10),
            Product.createProduct("Shorts", description: "Running Shorts",
                category: "Running", price: 30, stockLevel: 10),
            Product.createProduct("Shoes", description: "Running Shoes",
                category: "Running", price: 120, stockLevel: 10),
            ProductComposite(name: "Headgear", description: "Hat, etc",
                category: "Running", stockLevel: 10, products:
                Product.createProduct("Hat", description: "Running Hat",
                    category: "Running", price: 10, stockLevel: 10),
                Product.createProduct("Sunglasses", description: "Glasses",
                    category: "Running", price: 10, stockLevel: 10))
            ),        
        Product.createProduct("Kayak", description:"A boat for one person",
            category:"Watersports", price:275.0, stockLevel:0),
        Product.createProduct("Lifejacket",
            description:"Protective and fashionable",
            category:"Watersports", price:48.95, stockLevel:0),
        Product.createProduct("Soccer Ball",
            description:"FIFA-approved size and weight",
            category:"Soccer", price:19.5, stockLevel:0),
        Product.createProduct("Corner Flags",
            description:"Give your playing field a professional touch",
            category:"Soccer", price:34.95, stockLevel:0),
        Product.createProduct("Stadium",
            description:"Flat-packed 35,000-seat stadium",
            category:"Soccer", price:79500.0, stockLevel:0),
        Product.createProduct("Thinking Cap",
            description:"Improve your brain efficiency",
            category:"Chess", price:16.0, stockLevel:0),
        Product.createProduct("Unsteady Chair",
            description:"Secretly give your opponent a disadvantage",
            category: "Chess", price: 29.95, stockLevel:0),
        Product.createProduct("Human Chess Board",
            description:"A fun game for the family",
            category:"Chess", price:75.0, stockLevel:0),
        Product.createProduct("Bling-Bling King",
            description:"Gold-plated, diamond-studded King",
            category:"Chess", price:1200.0, stockLevel:0)];

}
