import Foundation

class CustomerOrder {
    let customer:String;
    let parts:[CarPart];
    
    init(customer:String, parts:[CarPart]) {
        self.customer = customer;
        self.parts = parts;
    }
    
    var totalPrice:Float {
        return reduce(parts, 0, {subtotal, part in
            return subtotal + part.price});
    }
    
    func printDetails() {
        println("Order for \(customer): Cost: \(formatCurrencyString(totalPrice))");
    }
    
    func formatCurrencyString(number:Float) -> String {
        let formatter = NSNumberFormatter();
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
        return formatter.stringFromNumber(number) ?? "";
    }
}
