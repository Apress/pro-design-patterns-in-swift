class Purchase : Printable {
    private let product:String;
    private let price:Float;
    
    init(product:String, price:Float) {
        self.product = product;
        self.price = price;
    }
    
    var description:String {
        return product;
    }
    
    var totalPrice:Float {
        return price;
    }
}
