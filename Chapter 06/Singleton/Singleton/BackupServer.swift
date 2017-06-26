import Foundation

class DataItem {
    
    enum ItemType : String {
        case Email = "Email Address";
        case Phone = "Telephone Number";
        case Card = "Credit Card Number";
    }
    
    var type:ItemType;
    var data:String;
    
    init(type:ItemType, data:String) {
        self.type = type; self.data = data;
    }
}

final class BackupServer {
    let name:String;
    fileprivate var data = [DataItem]();
    fileprivate let arrayQ = DispatchQueue(label: "arrayQ", attributes: []);
    
    fileprivate init(name:String) {
        self.name = name;
        globalLogger.log("Created new server \(name)");
    }
    
    func backup(_ item:DataItem) {
        arrayQ.sync(execute: {() in
            self.data.append(item);
            globalLogger.log(
                "\(self.name) backed up item of type \(item.type.rawValue)");
        })
    }
    
    func getData() -> [DataItem]{
        return data;
    }
    
    class var server:BackupServer {
        struct SingletonWrapper {
            static let singleton = BackupServer(name:"MainServer");
        }
        return SingletonWrapper.singleton;
    }
}
