import Foundation

class NetworkConnection {
    private let flyweight:NetConnFlyweight;
    
    init() {
        self.flyweight = NetConnFlyweightFactory.createFlyweight();
    }
    
    func getStockLevel(name:String) -> Int? {
        NSThread.sleepForTimeInterval(Double(rand() % 2));
        return self.flyweight.getStockLevel(name);
    }
}
