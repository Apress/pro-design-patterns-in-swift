protocol StockServer {
    
    func getStockLevel(product:String, callback: (String, Int) -> Void);
    func setStockLevel(product:String, stockLevel:Int);
}

class StockServerFactory {
    
    class func getStockServer() -> StockServer {
        return server;
    }
    
    private class var server:StockServer {
        struct singletonWrapper {
            static let singleton:StockServer = StockServerProxy();
        }
        return singletonWrapper.singleton;
    }
}

class StockServerProxy : StockServer {
    
    func getStockLevel(product: String, callback: (String, Int) -> Void) {
        let stockConn = NetworkPool.getConnection();
        let level = stockConn.getStockLevel(product);
        if (level != nil) {
            callback(product, level!);
        }
        NetworkPool.returnConnecton(stockConn);
    }
    
    func setStockLevel(product: String, stockLevel: Int) {
        let stockConn = NetworkPool.getConnection();
        stockConn.setStockLevel(product, level: stockLevel);
        NetworkPool.returnConnecton(stockConn);
    }
}
