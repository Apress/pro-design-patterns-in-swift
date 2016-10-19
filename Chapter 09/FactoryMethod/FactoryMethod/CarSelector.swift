class CarSelector {
    class func selectCar(passengers:Int) -> String? {
        return RentalCar.createRentalCar(passengers)?.name;
    }
}
