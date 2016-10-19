protocol NetConnFlyweight {
    
    func getStockLevel(name:String) -> Int?;
}

class NetConnFlyweightImpl : NetConnFlyweight {
    private let extrinsicData:[String: Int];
    
    private init(data:[String: Int]) {
        self.extrinsicData = data;
    }
    
    func getStockLevel(name: String) -> Int? {
        return extrinsicData[name];
    }
}

class NetConnFlyweightFactory {
    
    class func createFlyweight() -> NetConnFlyweight {
        return NetConnFlyweightImpl(data: stockData);
    }
    
    private class var stockData:[String: Int] {
        get {
            struct singletonWrapper {
                static let singleton = ["Kayak" : 10, "Lifejacket": 14,
                    "Soccer Ball": 32,"Corner Flags": 1, "Stadium": 4,
                    "Thinking Cap": 8, "Unsteady Chair": 3,
                    "Human Chess Board": 2, "Bling-Bling King":4
                ];
            }
            return singletonWrapper.singleton;
        }
    }
}
