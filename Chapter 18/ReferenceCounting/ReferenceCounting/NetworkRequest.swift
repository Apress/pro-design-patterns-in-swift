import Foundation;

protocol NetworkConnection {
    func connect();
    func disconnect();
    func sendCommand(command:String);
}

class NetworkConnectionFactory {
    class func createNetworkConnection() -> NetworkConnection {
        return connectionProxy;
    }
    
    private class var connectionProxy:NetworkConnection {
        get {
            struct singletonWrapper {
                static let singleton = NetworkRequestProxy();
            }
            return singletonWrapper.singleton;
        }
    }
}

private class NetworkConnectionImplementation : NetworkConnection {
    typealias me = NetworkConnectionImplementation;
    
    func connect() { me.writeMessage("Connect"); }
    func disconnect() { me.writeMessage("Disconnect"); }
    
    func sendCommand(command:String) {
        me.writeMessage("Command: \(command)");
        NSThread.sleepForTimeInterval(1);
        me.writeMessage("Command completed: \(command)");
    }
    
    private class func writeMessage(msg:String) {
        dispatch_async(self.queue, {() in
            println(msg);
        });
    }
    
    private class var queue:dispatch_queue_t {
        get {
            struct singletonWrapper {
                static let singleton = dispatch_queue_create("writeQ",
                    DISPATCH_QUEUE_SERIAL);
            }
            return singletonWrapper.singleton;
        }
    }
}

class NetworkRequestProxy : NetworkConnection {
    private let wrappedRequest:NetworkConnection;
    private let queue = dispatch_queue_create("commandQ", DISPATCH_QUEUE_SERIAL);
    private var referenceCount:Int = 0;
    private var connected = false;
    
    init() {
        wrappedRequest = NetworkConnectionImplementation();
    }
    
    func connect() { /* do nothing */ }
    func disconnect() { /* do nothing */ }
    
    func sendCommand(command: String) {
        self.referenceCount++;
        dispatch_sync(self.queue, {() in
            if (!self.connected && self.referenceCount > 0) {
                self.wrappedRequest.connect();
                self.connected = true;
            }
            self.wrappedRequest.sendCommand(command);
            self.referenceCount--;
            if (self.connected && self.referenceCount == 0) {
                self.wrappedRequest.disconnect();
                self.connected = false;
            }
        });
    }
}
