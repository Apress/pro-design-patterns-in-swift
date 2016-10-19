class NewCoStaffMember {
    private var name:String;
    private var role:String;
    
    init(name:String, role:String) {
        self.name = name; self.role = role;
    }
    
    func getName() -> String {
        return name;
    }
    
    func getJob() -> String {
        return role;
    }
}

class NewCoDirectory {
    private var staff:[String: NewCoStaffMember];
    
    init() {
        staff = ["Hans": NewCoStaffMember(name: "Hans", role: "Corp Counsel"),
            "Greta": NewCoStaffMember(name: "Greta", role: "VP, Legal")];
    }
    
    func getStaff() -> [String: NewCoStaffMember] {
        return staff;
    }
}
