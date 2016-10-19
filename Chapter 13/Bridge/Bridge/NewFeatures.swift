class SatelliteChannel : Channel {
    override func sendMessage(msg: Message) {
        println("Satellite: \(msg.contentToSend)");
    }
}

class PriorityMessage : ClearMessage {
    override var contentToSend:String {
        return "Important: \(super.contentToSend)";
    }
}
