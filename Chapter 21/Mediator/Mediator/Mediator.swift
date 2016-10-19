import Foundation;

protocol Peer {
    var name:String {get};
    var currentPosition:Position {get};
    func otherPlaneDidChangePosition(position:Position) -> Bool;
}

protocol Mediator {
    func registerPeer(peer:Peer);
    func unregisterPeer(peer:Peer);
    func changePosition(peer:Peer, pos:Position) -> Bool;
}

class AirplaneMediator : Mediator {
    private var peers:[String:Peer];
    private let queue = dispatch_queue_create("dictQ", DISPATCH_QUEUE_CONCURRENT);
    
    init() {
        peers = [String:Peer]();
    }
    
    func registerPeer(peer: Peer) {
        dispatch_barrier_sync(self.queue, { () in
            self.peers[peer.name] = peer;
        });
    }
    
    func unregisterPeer(peer: Peer) {
        dispatch_barrier_sync(self.queue, { () in
            let removed = self.peers.removeValueForKey(peer.name);
        });
    }
    
    func changePosition(peer:Peer, pos:Position) -> Bool {
        var result = false;
        dispatch_sync(self.queue, { () in
            
            let closerPeers = self.peers.values.filter({p in
                return p.currentPosition.distanceFromRunway
                    <= pos.distanceFromRunway;
            });
            
            for storedPeer in closerPeers {
                if (peer.name != storedPeer.name
                    && storedPeer.otherPlaneDidChangePosition(pos)) {
                        result = true;
                }
            }
        });
        return result;
    }
}
