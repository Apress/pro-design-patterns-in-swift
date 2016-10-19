let account = CustomerAccount(name:"Joe");

account.addPurchase(Purchase(product: "Red Hat", price: 10));
account.addPurchase(Purchase(product: "Scarf", price: 20));
account.addPurchase(EndOfLineDecorator(purchase: BlackFridayDecorator(purchase:
    GiftOptionDecorator(purchase: Purchase(product: "Sunglasses", price:25),
        options: GiftOptionDecorator.OPTION.GIFTWRAP,
        GiftOptionDecorator.OPTION.DELIVERY))));

account.printAccount();

for p in account.purchases {
    if let d = p as? DiscountDecorator {
        println("\(p) has \(d.countDiscounts()) discounts");
    } else {
        println("\(p) has no discounts");
    }
}
