import Foundation;

class PirateShip {
    
    struct ShipLocation {
        let NorthSouth:Int;
        let EastWest:Int;
    }
    
    var currentPosition:ShipLocation;
    var movementQueue = dispatch_queue_create("shipQ", DISPATCH_QUEUE_SERIAL);
    
    init() {
        currentPosition = ShipLocation(NorthSouth: 5, EastWest: 5);
    }
    
    func moveToLocation(location:ShipLocation, callback:(ShipLocation) -> Void) {
        dispatch_async(movementQueue, {() in
            self.currentPosition = location;
            callback(self.currentPosition);
        });
    }
}
