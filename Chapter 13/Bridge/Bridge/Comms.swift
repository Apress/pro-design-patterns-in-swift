//protocol ClearMessageChannel {
//    func send(message:String);
//}
//
//protocol SecureMessageChannel {
//    func sendEncryptedMessage(message:String);
//}
//
//protocol PriorityMessageChannel {
//    func sendPriority(message:String);
//}

class Communicator {
    private let channnel:Channel;
    
    init (channel:Channel.Channels) {
        self.channnel = Channel.getChannel(channel);
    }
    
    private func sendMessage(msg:Message) {
        msg.prepareMessage();
        channnel.sendMessage(msg);
    }
    
    func sendCleartextMessage(message:String) {
        self.sendMessage(ClearMessage(message: message));
    }
    
    func sendSecureMessage(message:String) {
        self.sendMessage(EncryptedMessage(message: message));
    }
    
    func sendPriorityMessage(message:String) {
        self.sendMessage(PriorityMessage(message: message));
    }
}
