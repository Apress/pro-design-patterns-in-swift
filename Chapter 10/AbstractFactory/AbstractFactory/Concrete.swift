class CompactCarFactory : CarFactory {
    override func createFloorplan() -> Floorplan {
        return StandardFloorplan();
    }
    override func createSuspension() -> Suspension {
        return RoadSuspension.getInstance();
    }
    override func createDrivetrain() -> Drivetrain {
        return FrontWheelDrive();
    }
}

class SportsCarFactory : CarFactory {
    
    override func createFloorplan() -> Floorplan {
        return ShortFloorplan();
    }
    override func createSuspension() -> Suspension {
        return RaceSuspension.getInstance();
    }
    override func createDrivetrain() -> Drivetrain {
        return AllWheelDrive();
    }
    
    override class var sharedInstance:CarFactory? {
        get {
            struct SingletonWrapper {
                static let singleton = SportsCarFactory();
            }
            return SingletonWrapper.singleton;
        }
    }
}

class SUVCarFactory : CarFactory {
    override func createFloorplan() -> Floorplan {
        return LongFloorplan();
    }
    override func createSuspension() -> Suspension {
        return OffRoadSuspension.getInstance();
    }
    override func createDrivetrain() -> Drivetrain {
        return AllWheelDrive();
    }
}
