class AuthenticationManager : ShortLivedSubject {
    
    func authenticate(user:String, pass:String) -> Bool {
        var nType = NotificationTypes.AUTH_FAIL;
        if (user == "bob" && pass == "secret") {
            nType = NotificationTypes.AUTH_SUCCESS;
            println("User \(user) is authenticated");
        } else {
            println("Failed authentication attempt");
        }
        sendNotification(Notification(type: nType, data: user));
        return nType == NotificationTypes.AUTH_SUCCESS;
    }
}
