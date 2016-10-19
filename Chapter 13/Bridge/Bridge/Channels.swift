class Channel {
    
    enum Channels {
        case Landline;
        case Wireless;
        case Satellite;
    }
    
    class func getChannel(channelType:Channels) -> Channel {
        switch channelType {
        case .Landline:
            return LandlineChannel();
        case .Wireless:
            return WirelessChannel();
        case .Satellite:
            return SatelliteChannel();
        }
    }
    
    func sendMessage(msg:Message) {
        fatalError("Not implemented");
    }
}

class LandlineChannel : Channel {
    override func sendMessage(msg: Message) {
        println("Landline: \(msg.contentToSend)");
    }
    
}

class WirelessChannel : Channel {
    override func sendMessage(msg: Message) {
        println("Wireless: \(msg.contentToSend)");
    }
}
