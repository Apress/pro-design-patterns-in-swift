protocol CommandPeer {
    var name:String { get };
}

class Command {
    let function:CommandPeer -> Any;
    
    init(function:CommandPeer -> Any) {
        self.function = function;
    }
    
    func execute(peer:CommandPeer) -> Any {
        return function(peer);
    }
}

class CommandMediator {
    private var peers = [String:CommandPeer]();
    
    func registerPeer(peer:CommandPeer) {
        peers[peer.name] = peer;
    }
    
    func unregisterPeer(peer:CommandPeer) {
        peers.removeValueForKey(peer.name);
    }
    
    func dispatchCommand(caller:CommandPeer, command:Command) -> [Any] {
        var results = [Any]();
        for peer in peers.values {
            if (peer.name != caller.name) {
                results.append(command.execute(peer));
            }
        }
        return results;
    }
}
