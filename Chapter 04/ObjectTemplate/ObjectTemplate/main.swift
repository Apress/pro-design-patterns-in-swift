var products = [
    Product(name: "Kayak", price: 275, stock: 10),
    Product(name: "Lifejacket", price: 48.95, stock: 14),
    Product(name: "Soccer Ball", price: 19.5, stock: 32)];

func calculateStockValue(productsArray:[Product]) -> Double {
    return productsArray.reduce(0, {(total, product) -> Double in
        return total + product.stockValue;
    });
}

println("Sales tax for Kayak: $\(products[0].calculateTax(0.2))");
println("Total value of stock: $\(calculateStockValue(products))");
products[0].stock = -50;
println("Stock Level for Kayak: \(products[0].stock)");
