protocol MessagePeer {
    var name:String { get };
    func handleMessage(messageType:String, data:Any?) -> Any?;
}

class MessageMediator {
    private var peers = [String:MessagePeer]();
    
    func registerPeer(peer:MessagePeer) {
        peers[peer.name] = peer;
    }
    
    func unregisterPeer(peer:MessagePeer) {
        peers.removeValueForKey(peer.name);
    }
    
    func sendMessage(caller:MessagePeer, messageType:String, data:Any) -> [Any?] {
        var results = [Any?]();
        for peer in peers.values {
            if (peer.name != caller.name) {
                results.append(peer.handleMessage(messageType, data: data));
            }
        }
        return results;
    }
}
