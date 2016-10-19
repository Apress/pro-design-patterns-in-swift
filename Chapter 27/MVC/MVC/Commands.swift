import Foundation

enum Command : String {
    case LIST_PEOPLE = "L: List People";
    case ADD_PERSON = "A: Add Person";
    case DELETE_PERSON = "D: Delete Person";
    case UPDATE_PERSON = "U: Update Person";
    case SEARCH = "S: Search";
    case LIST_CITIES = "LC: List Cities";
    case SEARCH_CITIES = "SC: Search Cities";
    case DELETE_CITY = "DC: Delete City";
    
    
    static let ALL = [Command.LIST_PEOPLE, Command.ADD_PERSON,
        Command.DELETE_PERSON, Command.UPDATE_PERSON, Command.SEARCH,
        Command.LIST_CITIES, Command.SEARCH_CITIES, Command.DELETE_CITY];
    
    static func getFromInput(input:String) -> Command? {
        switch (input.lowercaseString) {
        case "l":
            return Command.LIST_PEOPLE;
        case "a":
            return Command.ADD_PERSON;
        case "d":
            return Command.DELETE_PERSON;
        case "u":
            return Command.UPDATE_PERSON;
        case "s":
            return Command.SEARCH;
        case "lc":
            return Command.LIST_CITIES;
        case "sc":
            return Command.SEARCH_CITIES;
        case "dc":
            return Command.DELETE_CITY;
        default:
            return nil;
        }
    }
}
