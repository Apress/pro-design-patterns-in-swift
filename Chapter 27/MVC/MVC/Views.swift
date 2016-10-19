protocol View {
    
    func execute();
}

class PersonListView : View {
    private let people:[Person];
    
    init(data:[Person]) {
        self.people = data;
    }
    
    func execute() {
        for person in people {
            println(person);
        }
    }
}

class CityListView : View {
    private let cities:[String];
    
    init(data:[String]) {
        self.cities = data;
    }
    
    func execute() {
        for city in self.cities {
            println("City: \(city)");
        }
    }
}

