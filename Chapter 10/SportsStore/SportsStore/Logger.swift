import Foundation

let productLogger = Logger<Product>(callback: {p in
    println("Change: \(p.name) \(p.stockLevel) items in stock");
});

final class Logger<T where T:NSObject, T:NSCopying> {
    var dataItems:[T] = [];
    var callback:(T) -> Void;
    var arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_CONCURRENT);
    var callbackQ = dispatch_queue_create("callbackQ", DISPATCH_QUEUE_SERIAL);
    
    private init(callback:T -> Void, protect:Bool = true) {
        self.callback = callback;
        if (protect) {
            self.callback = {(item:T) in
                dispatch_sync(self.callbackQ, {() in
                    callback(item);
                });
            };
        }
    }
    
    func logItem(item:T) {
        dispatch_barrier_async(arrayQ, {() in
            self.dataItems.append(item.copy() as T);
            self.callback(item);
        });
    }
    
    func processItems(callback:T -> Void) {
        dispatch_sync(arrayQ, {() in
            for item in self.dataItems {
                callback(item);
            }
        });
    }
}
