protocol Drivetrain {
    var driveType:DriveOption { get };
}

enum DriveOption : String {
    case FRONT = "Front"; case REAR = "Rear"; case ALL = "4WD";
}

class FrontWheelDrive : Drivetrain {
    var driveType = DriveOption.FRONT;
}

class RearWheelDrive : Drivetrain {
    var driveType = DriveOption.REAR;
}

class AllWheelDrive : Drivetrain {
    var driveType = DriveOption.ALL;
}
