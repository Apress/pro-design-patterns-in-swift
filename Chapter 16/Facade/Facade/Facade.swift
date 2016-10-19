import Foundation

enum TreasureTypes {
    case SHIP; case BURIED; case SUNKEN;
}

class PirateFacade {
    let map = TreasureMap();
    let ship = PirateShip();
    let crew = PirateCrew();
    
    func getTreasure(type:TreasureTypes) -> Int? {
        
        var prizeAmount:Int?;
        
        // select the treasure type
        var treasureMapType:TreasureMap.Treasures;
        var crewWorkType:PirateCrew.Actions;
        
        switch (type) {
        case .SHIP:
            treasureMapType = TreasureMap.Treasures.GALLEON;
            crewWorkType = PirateCrew.Actions.ATTACK_SHIP;
        case .BURIED:
            treasureMapType = TreasureMap.Treasures.BURIED_GOLD;
            crewWorkType = PirateCrew.Actions.DIG_FOR_GOLD;
        case .SUNKEN:
            treasureMapType = TreasureMap.Treasures.SUNKEN_JEWELS;
            crewWorkType = PirateCrew.Actions.DIVE_FOR_JEWELS;
        }
        
        let treasureLocation = map.findTreasure(treasureMapType);
        
        // convert from map to ship coordinates
        let sequence:[Character] = ["A", "B", "C", "D", "E", "F", "G"];
        let eastWestPos = find(sequence, treasureLocation.gridLetter);
        let shipTarget = PirateShip.ShipLocation(NorthSouth:
            Int(treasureLocation.gridNumber), EastWest: eastWestPos!);
        
        let semaphore = dispatch_semaphore_create(0);
        
        // relocate ship
        ship.moveToLocation(shipTarget, callback: {location in
            self.crew.performAction(crewWorkType, {prize in
                prizeAmount = prize;
                dispatch_semaphore_signal(semaphore);
            });
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        return prizeAmount;
    }
}
