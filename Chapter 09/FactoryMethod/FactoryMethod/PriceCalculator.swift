class PriceCalculator {
    class func calculatePrice(passengers:Int, days:Int) -> Float? {
        var car = RentalCar.createRentalCar(passengers);
        return car == nil ? nil : car!.pricePerDay * Float(days);
    }
}
