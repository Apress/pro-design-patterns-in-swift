class Transmitter {
    var nextLink:Transmitter?;
    
    required init() {}
    
    func sendMessage(message:Message, handled: Bool = false) -> Bool {
        if (nextLink != nil) {
            return nextLink!.sendMessage(message, handled: handled);
        } else if (!handled) {
            println("End of chain reached. Message not sent");
        }
        return handled;
    }
    
    class func createChain(localOnly:Bool) -> Transmitter? {
        
        let transmitterClasses:[Transmitter.Type]
            = localOnly ? [PriorityTransmitter.self, LocalTransmitter.self]
            : [PriorityTransmitter.self, LocalTransmitter.self, RemoteTransmitter.self];
        
        var link:Transmitter?;
        
        for tClass in transmitterClasses.reverse() {
            let existingLink = link;
            link = tClass();
            link?.nextLink = existingLink;
        }
        
        return link;
    }

    private class func matchEmailSuffix(message:Message) -> Bool {
        if let index = find(message.from, "@") {
            return message.to.hasSuffix(message.from[Range<String.Index>(start:
                index, end: message.from.endIndex)]);
        }
        return false;
    }
}

class LocalTransmitter : Transmitter {
    
    override func sendMessage(message: Message, var handled:Bool) -> Bool {
        if (!handled && Transmitter.matchEmailSuffix(message)) {
            println("Message to \(message.to) sent locally");
            handled = true;
        }
        return super.sendMessage(message, handled: handled);
    }
}

class RemoteTransmitter : Transmitter {
    
    override func sendMessage(message: Message, var handled: Bool) -> Bool {
        if (!handled && !Transmitter.matchEmailSuffix(message)) {
            println("Message to \(message.to) sent remotely");
            handled = true;
        }
        return super.sendMessage(message, handled: handled);
    }
}

class PriorityTransmitter : Transmitter {
    var totalMessages = 0;
    var handledMessages = 0;
    
    override func sendMessage(message: Message, var handled:Bool) -> Bool {
        totalMessages++;
        if (!handled && message.subject.hasPrefix("Priority")) {
            handledMessages++;
            println("Message to \(message.to) sent as priority");
            println("Stats: Handled \(handledMessages) of \(totalMessages)");
            handled = true;
        }
        return super.sendMessage(message, handled: handled);
    }
}

