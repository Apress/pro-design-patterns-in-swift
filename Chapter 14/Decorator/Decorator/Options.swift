class GiftOptionDecorator : Purchase {
    private let wrappedPurchase:Purchase;
    private let options:[OPTION];
    
    enum OPTION {
        case GIFTWRAP;
        case RIBBON;
        case DELIVERY;
    }
    
    init(purchase:Purchase, options:OPTION...) {
        self.wrappedPurchase = purchase;
        self.options = options;
        super.init(product: purchase.description, price: purchase.totalPrice);
    }
    
    override var description:String {
        var result = wrappedPurchase.description;
        for option in options {
            switch (option) {
            case .GIFTWRAP:
                result = "\(result) + giftwrap";
            case .RIBBON:
                result = "\(result) + ribbon";
            case .DELIVERY:
                result = "\(result) + delivery";
            }
        }
        return result;
    }
    
    override var totalPrice:Float {
        var result = wrappedPurchase.totalPrice;
        for option in options {
            switch (option) {
            case .GIFTWRAP:
                result += 2;
            case .RIBBON:
                result += 1;
            case .DELIVERY:
                result += 5;
            }
        }
        return result;
    }
}
