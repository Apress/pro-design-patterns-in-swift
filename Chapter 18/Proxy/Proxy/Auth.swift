class UserAuthentication {
    var user:String?;
    var authenticated:Bool = false;
    
    private init() {
        // do nothing - stops instances being created
    }
    
    func authenticate(user:String, pass:String) {
        if (pass == "secret") {
            self.user = user;
            self.authenticated = true;
        } else {
            self.user = nil;
            self.authenticated = false;
        }
    }
    
    class var sharedInstance:UserAuthentication {
        get {
            struct singletonWrapper {
                static let singleton = UserAuthentication();
            }
            return singletonWrapper.singleton;
        }
    }
}
