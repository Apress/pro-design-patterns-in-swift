import Foundation

class Person : NSObject, NSCopying {
    var name:String
    var country: String
    
    init(name:String, country:String) {
        self.name = name; self.country = country;
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Person(name: self.name, country: self.country);
    }
}

var data = NSMutableArray(objects: 10, "iOS", Person(name:"Joe", country:"USA"));
var copiedData = NSMutableArray(array: data, copyItems: true);

data[0] = 20;
data[1] = "MacOS";
(data[2] as Person).name = "Alice"

println("Identity: \(data === copiedData)");
println("0: \(copiedData[0]) 1: \(copiedData[1]) 2: \(copiedData[2].name)");
