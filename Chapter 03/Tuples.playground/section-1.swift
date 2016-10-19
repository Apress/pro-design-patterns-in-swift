import Foundation;

var myProduct = ("Kayak", "A boat for one person", "Watersports", 275.0, 10);

func writeProductDetails(product: (String, String, String, Double, Int)) {
    println("Name: \(product.0)");
    println("Description: \(product.1)");
    println("Category: \(product.2)");
    let formattedPrice = NSString(format: "$%.2lf", product.3);
    println("Price: \(formattedPrice)");
}

writeProductDetails(myProduct);
