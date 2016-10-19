import Foundation

class CustomerAccount {
    let customerName:String;
    var purchases = [Purchase]();
    
    init(name:String) {
        self.customerName = name;
    }
    
    func addPurchase(purchase:Purchase) {
        self.purchases.append(purchase);
    }
    
    func printAccount() {
        var total:Float = 0;
        for p in purchases {
            total += p.totalPrice;
            println("Purchase \(p), Price \(formatCurrencyString(p.totalPrice))");
        }
        println("Total due: \(formatCurrencyString(total))");
    }
    
    func formatCurrencyString(number:Float) -> String {
        let formatter = NSNumberFormatter();
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle;
        return formatter.stringFromNumber(number) ?? "";
    }
}
