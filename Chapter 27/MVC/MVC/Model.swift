import Foundation

func == (lhs:Person, rhs:Person) -> Bool {
    return lhs.name == rhs.name && lhs.city == rhs.city;
}

class Person : Equatable, Printable {
    var name:String;
    var city:String;
    
    init(_ name:String, _ city:String) {
        self.name = name;
        self.city = city;
    }
    
    var description: String {
        return "Name: \(self.name), City: \(self.city)";
    }
}

protocol Repository {
    
    var People:[Person] { get };
    
    func addPerson(person:Person);
    func removePerson(name:String);
    func updatePerson(name:String, newCity:String);
}

class MemoryRepository : Repository {
    private var peopleArray:[Person];
    
    init() {
        peopleArray = [
            Person("Bob", "New York"),
            Person("Alice", "London"),
            Person("Joe", "Paris")];
    }
    
    var People:[Person] {
        return self.peopleArray;
    }
    
    func addPerson(person: Person) {
        self.peopleArray.append(person);
    }
    
    func removePerson(name: String) {
        let nameLower = name.lowercaseString;
        self.peopleArray = peopleArray
            .filter({$0.name.lowercaseString != nameLower});
    }
    
    func updatePerson(name: String, newCity: String) {
        let nameLower = name.lowercaseString;
        let test:Person -> Bool = {p in return p.name.lowercaseString == nameLower};
        if let person = peopleArray.first(test) {
            person.city = newCity;
        }
    }
}
