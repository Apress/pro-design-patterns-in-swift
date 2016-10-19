import Foundation

class Person : NSObject, NSCopying {
    var name:String;
    var country:String;
    
    init(name:String, country:String) {
        self.name = name; self.country = country;
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Person(name: self.name, country: self.country);
    }
}

func deepCopy(data:[AnyObject]) -> [AnyObject] {
    return data.map({item -> AnyObject in
        if (item is NSCopying && item is NSObject) {
            return (item as NSObject).copy();
        } else {
            return item;
        }
    })
}

var people = [Person(name:"Joe", country:"France"),
    Person(name:"Bob", country:"USA")];
var otherpeople = deepCopy(people) as [Person];

people[0].country = "UK";
println("Country: \(otherpeople[0].country)");
