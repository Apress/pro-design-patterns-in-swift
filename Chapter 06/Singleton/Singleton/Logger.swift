import Foundation;

let globalLogger = Logger();

final class Logger {
    private var data = [String]()
    private let arrayQ = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL);
    
    private init() {
        // do nothing - required to stop instances being
        // created by code in other files
    }
    
    func log(msg:String) {
        dispatch_sync(arrayQ, {() in
            self.data.append(msg);
        });
    }
    
    func printLog() {
        for msg in data {
            println("Log: \(msg)");
        }
    }
}
