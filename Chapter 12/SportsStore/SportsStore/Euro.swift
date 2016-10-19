class EuroHandler {
    
    func getDisplayString(amount:Double) -> String {
        let formatted = Utils.currencyStringFromNumber(amount);
        return "€\(dropFirst(formatted))";
    }
    
    func getCurrencyAmount(amount:Double) -> Double {
        return 0.76164 * amount;
    }
}
