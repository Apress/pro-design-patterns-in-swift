import Foundation;

let globalLogger = Logger();

final class Logger {
    fileprivate var data = [String]()
    fileprivate let arrayQ = DispatchQueue(label: "arrayQ", attributes: []);
    
    fileprivate init() {
        // do nothing - required to stop instances being
        // created by code in other files
    }
    
    func log(_ msg:String) {
        arrayQ.sync(execute: {() in
            self.data.append(msg);
        });
    }
    
    func printLog() {
        for msg in data {
            print("Log: \(msg)");
        }
    }
}
