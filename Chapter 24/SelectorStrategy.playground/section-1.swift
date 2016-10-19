import Foundation;

@objc class City {
    let name:String;
    
    init(_ name:String) {
        self.name = name;
    }
    
    func compareTo(other:City) -> NSComparisonResult {
        if (self.name == other.name) {
            return NSComparisonResult.OrderedSame;
        } else if (self.name < other.name) {
            return NSComparisonResult.OrderedDescending;
        } else {
            return NSComparisonResult.OrderedAscending;
        }
    }
}

let nsArray = NSArray(array: [City("London"), City("New York"),
    City("Paris"), City("Rome")]);
let sorted = nsArray.sortedArrayUsingSelector("compareTo:");

for city in sorted {
    println(city.name);
}
