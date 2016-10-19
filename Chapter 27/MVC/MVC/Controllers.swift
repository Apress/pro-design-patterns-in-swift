class ControllerBase {
    private let repository:Repository;
    private let nextController:ControllerBase?;
    
    init(repo:Repository, nextController:ControllerBase?) {
        self.repository = repo;
        self.nextController = nextController;
    }
    
    func handleCommand(command:Command, data:[String]) -> View? {
        return nextController?.handleCommand(command, data:data);
    }
}

class PersonController : ControllerBase {
    
    override func handleCommand(command: Command, data:[String]) -> View? {
        switch command {
        case .LIST_PEOPLE:
            return listAll();
        case .ADD_PERSON:
            return addPerson(data[0], city: data[1]);
        case .DELETE_PERSON:
            return deletePerson(data[0]);
        case .UPDATE_PERSON:
            return updatePerson(data[0], newCity:data[1]);
        case .SEARCH:
            return search(data[0]);
        default:
            return super.handleCommand(command, data: data);
        }
    }
    
    private func listAll() -> View {
        return PersonListView(data:repository.People);
    }
    
    private func addPerson(name:String, city:String) -> View {
        repository.addPerson(Person(name, city));
        return listAll();
    }
    
    private func deletePerson(name:String) -> View {
        repository.removePerson(name);
        return listAll();
    }
    
    private func updatePerson(name:String, newCity:String) -> View {
        repository.updatePerson(name, newCity: newCity);
        return listAll();
    }
    
    private func search(term:String) -> View {
        let termLower = term.lowercaseString;
        let matches = repository.People.filter({ person in
            return person.name.lowercaseString.rangeOfString(termLower) != nil
                || person.city.lowercaseString.rangeOfString(termLower) != nil});
        return PersonListView(data: matches);
    }
}

class CityController : ControllerBase {
    
    override func handleCommand(command: Command, data: [String]) -> View? {
        switch command {
        case .LIST_CITIES:
            return listAll();
        case .SEARCH_CITIES:
            return search(data[0]);
        case .DELETE_CITY:
            return delete(data[0]);
        default:
            return super.handleCommand(command, data: data);
        }
    }
    
    private func listAll() -> View {
        return CityListView(data: repository.People.map({$0.city}).unique());
    }
    
    private func search(city:String) -> View {
        let cityLower = city.lowercaseString;
        let matches:[Person] = repository.People
            .filter({ $0.city.lowercaseString == cityLower });
        return PersonListView(data: matches);
    }
    
    private func delete(city:String) -> View {
        let cityLower = city.lowercaseString;
        let toDelete = repository.People
            .filter({ $0.city.lowercaseString == cityLower });
        for person in toDelete {
            repository.removePerson(person.name);
        }
        return PersonListView(data: repository.People);
    }
}
