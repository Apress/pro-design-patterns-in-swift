import Foundation;

let facade = PirateFacade();
let prize = facade.getTreasure(TreasureTypes.SHIP);
if (prize != nil) {
    facade.crew.performAction(PirateCrew.Actions.DIVE_FOR_JEWELS,
        callback: {secondPrize in
            println("Prize: \(prize! + secondPrize) pieces of eight");
    });
}

NSFileHandle.fileHandleWithStandardInput().availableData;
