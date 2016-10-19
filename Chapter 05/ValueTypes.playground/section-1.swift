struct Appointment {
    var name:String;
    var day:String;
    var place:String;
    
    func printDetails(label:String) {
        println("\(label) with \(name) on \(day) at \(place)");
    }
}

var beerMeeting = Appointment(name: "Bob", day: "Mon", place: "Joe's Bar");

var workMeeting = beerMeeting;
workMeeting.name = "Alice";
workMeeting.day = "Fri";
workMeeting.place = "Conference Rm 2";

beerMeeting.printDetails("Social");
workMeeting.printDetails("Work");
