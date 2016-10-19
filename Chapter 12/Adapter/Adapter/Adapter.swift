class NewCoDirectoryAdapter : EmployeeDataSource {
    private let directory:NewCoDirectory;
    
    init() {
        directory = NewCoDirectory();
    }
    
    var employees:[Employee] {
        return map(directory.getStaff().values, { sv -> Employee in
            return Employee(name: sv.getName(), title: sv.getJob());
        });
    }
    
    func searchByName(name:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getName().rangeOfString(name) != nil;
        });
    }
    
    func searchByTitle(title:String) -> [Employee] {
        return createEmployees(filter: {(sv:NewCoStaffMember) -> Bool in
            return sv.getJob().rangeOfString(title) != nil;
        });
    }
    
    private func createEmployees(filter filterClosure:(NewCoStaffMember -> Bool))
        -> [Employee] {
            return map(filter(directory.getStaff().values, filterClosure),
                {entry -> Employee in
                    return Employee(name: entry.getName(), title: entry.getJob());
            });
    }
}
