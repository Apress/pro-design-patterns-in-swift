import Foundation

var server = BackupServer.server;

let queue = DispatchQueue(label: "workQueue", attributes: DispatchQueue.Attributes.concurrent);
let group = DispatchGroup();

for count in 0 ..< 100 {
    queue.async(group: group, execute: {() in
        BackupServer.server.backup(DataItem(type: DataItem.ItemType.Email,
            data: "bob@example.com"))
    });
}

group.wait(timeout: DispatchTime.distantFuture);

print("\(server.getData().count) items were backed up");
