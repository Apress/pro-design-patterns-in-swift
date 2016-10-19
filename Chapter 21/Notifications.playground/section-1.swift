import Foundation;

let notifier = NSNotificationCenter.defaultCenter();

@objc class NotificationPeer {
    let name:String;
    
    init(name:String) {
        self.name = name;
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveMessage:", name: "message", object: nil);
    }
    
    func sendMessage(message:String) {
        NSNotificationCenter.defaultCenter().postNotificationName("message",
            object: message);
    }
    
    func receiveMessage(notification:NSNotification) {
        println("Peer \(name) received message: \(notification.object)");
    }
}

let p1 = NotificationPeer(name: "peer1");
let p2 = NotificationPeer(name: "peer2");
let p3 = NotificationPeer(name: "peer3");
let p4 = NotificationPeer(name: "peer4");

p3.sendMessage("Hello!");
