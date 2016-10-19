protocol Message {
    init (message:String);
    func prepareMessage();
    var contentToSend:String { get };
}

class ClearMessage : Message {
    private var message:String;
    
    required init(message:String) {
        self.message = message;
    }
    
    func prepareMessage() {
        // no action required
    }
    
    var contentToSend:String {
        return message;
    }
}

class EncryptedMessage : Message {
    private var clearText:String;
    private var cipherText:String?;
    
    required init(message:String) {
        self.clearText = message;
    }
    
    func prepareMessage() {
        cipherText = String(reverse(clearText));
    }
    
    var contentToSend:String {
        return cipherText!;
    }
}
