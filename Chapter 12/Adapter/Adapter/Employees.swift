struct Employee {
    var name:String;
    var title:String;
}

protocol EmployeeDataSource {
    var employees:[Employee] { get };
    func searchByName(name:String) -> [Employee];
    func searchByTitle(title:String) -> [Employee];
}
