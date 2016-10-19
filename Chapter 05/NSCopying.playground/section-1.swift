import Foundation

class LogItem {
    var from:String?;
    @NSCopying var data:NSArray?
}

var dataArray = NSMutableArray(array: [1, 2, 3, 4]);

var logitem = LogItem()
logitem.from = "Alice";
logitem.data = dataArray;

dataArray[1] = 10;
println("Value: \(logitem.data![1])");
