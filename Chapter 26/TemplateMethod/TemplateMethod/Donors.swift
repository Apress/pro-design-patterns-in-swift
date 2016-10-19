struct Donor {
    let title:String;
    let firstName:String;
    let familyName:String;
    let lastDonation:Float;
    
    init (_ title:String, _ first:String, _ family:String, _ last:Float) {
        self.title = title;
        self.firstName = first;
        self.familyName = family;
        self.lastDonation = last;
    }
}

class DonorDatabase {
    private var donors:[Donor];
    
    init() {
        donors = [
            Donor("Ms", "Anne", "Jones", 0),
            Donor("Mr", "Bob", "Smith", 100),
            Donor("Dr", "Alice", "Doe", 200),
            Donor("Prof", "Joe", "Davis", 320)];
    }
    
    func filter(donors:[Donor]) -> [Donor] {
        return donors.filter({$0.lastDonation > 0});
    }
    
    func generate(donors:[Donor]) -> [String] {
        return donors.map({ donor in
            return "Dear \(donor.title). \(donor.familyName)";
        })
    }
    
    func generate(maxNumber:Int) -> [String] {
        
        // step 1 - filter out non-donors
        var targetDonors = filter(self.donors);
        
        // step 2 - order donors by last donation
        targetDonors.sort({ $0.lastDonation > $1.lastDonation});
        
        // step 3 - limit the number of invitees
        if (targetDonors.count > maxNumber) {
            targetDonors = Array(targetDonors[0..<maxNumber]);
        }
        
        // step 4 - generate the invitations
        return generate(targetDonors);
    }
}
