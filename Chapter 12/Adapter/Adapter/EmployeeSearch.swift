class SearchTool {
    
    enum SearchType {
        case NAME; case TITLE;
    }
    
    private let sources:[EmployeeDataSource];
    
    init(dataSources: EmployeeDataSource...) {
        self.sources = dataSources;
    }
    
    var employees:[Employee] {
        var results = [Employee]();
        for source in sources {
            results += source.employees;
        }
        return results;
    }
    
    
    func search(text:String, type:SearchType) -> [Employee] {
        var results = [Employee]();
        
        for source in sources {
            results += type == SearchType.NAME ? source.searchByName(text)
                : source.searchByTitle(text);
        }
        return results;
    }
}
