import Foundation;

let queue = dispatch_queue_create("requestQ", DISPATCH_QUEUE_CONCURRENT);

for count in 0 ..< 3 {
    
    let connection = NetworkConnectionFactory.createNetworkConnection();
    
    dispatch_async(queue, {() in
        connection.connect();
        connection.sendCommand("Command: \(count)");
        connection.disconnect();
    });
}

NSFileHandle.fileHandleWithStandardInput().availableData;
