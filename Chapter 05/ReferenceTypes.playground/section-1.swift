import Foundation

class Location : NSObject, NSCopying {
    var name:String;
    var address:String;
    
    init(name:String, address:String) {
        self.name = name; self.address = address;
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Location(name: self.name, address:self.address);
    }
}

class Appointment : NSObject, NSCopying {
    var name:String;
    var day:String;
    var place:Location;
    
    init(name:String, day:String, place:Location) {
        self.name = name; self.day = day; self.place = place;
    }
    
    func printDetails(label:String) {
        println("\(label) with \(name) on \(day) at \(place.name), "
            + "\(place.address)");
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Appointment(name:self.name, day:self.day,
            place:self.place.copy() as Location);
    }
}

var beerMeeting = Appointment(name: "Bob", day: "Mon",
    place: Location(name:"Joe's Bar", address: "123 Main St"));

var workMeeting = beerMeeting.copy() as Appointment;

workMeeting.name = "Alice";
workMeeting.day = "Fri";
workMeeting.place.name = "Conference Rm 2";
workMeeting.place.address = "Company HQ";

beerMeeting.printDetails("Social");
workMeeting.printDetails("Work");
