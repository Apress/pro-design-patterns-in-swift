import Foundation

@objc protocol Suspension {
    var suspensionType:SuspensionOption { get };
    
    class func getInstance() -> Suspension;
}

class RoadSuspension : Suspension {
    var suspensionType = SuspensionOption.STANDARD;
    
    private init() {};
    
    class func getInstance() -> Suspension {
        return RoadSuspension();
    }
}

class OffRoadSuspension : Suspension {
    var suspensionType = SuspensionOption.SOFT;
    
    private init() {};
    
    class func getInstance() -> Suspension {
        return OffRoadSuspension();
    }
}

class RaceSuspension : NSObject, NSCopying, Suspension {
    var suspensionType = SuspensionOption.SPORTS;
    
    private override init() {};
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return RaceSuspension();
    }
    
    private class var prototype:RaceSuspension {
        get {
            struct SingletonWrapper {
                static let singleton = RaceSuspension();
            }
            return SingletonWrapper.singleton;
        }
    }
    
    class func getInstance() -> Suspension {
        return prototype.copy() as Suspension;
    }
}
