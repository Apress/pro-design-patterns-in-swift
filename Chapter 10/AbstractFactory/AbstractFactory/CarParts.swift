enum Cars: String {
    case COMPACT = "VW Golf";
    case SPORTS = "Porsche Boxter";
    case SUV = "Cadillac Escalade";
}

struct Car {
    var carType:Cars;
    var floor:Floorplan;
    var suspension:Suspension;
    var drive:Drivetrain;
    
    init(carType:Cars) {
        let concreteFactory = CarFactory.getFactory(carType);
        self.floor = concreteFactory!.createFloorplan();
        self.suspension = concreteFactory!.createSuspension();
        self.drive = concreteFactory!.createDrivetrain();
        self.carType = carType;
    }
    
    func printDetails() {
        println("Car type: \(carType.rawValue)");
        println("Seats: \(floor.seats)");
        println("Engine: \(floor.enginePosition.rawValue)");
        println("Suspension: \(suspension.suspensionType.rawValue)");
        println("Drive: \(drive.driveType.rawValue)");
    }
}
