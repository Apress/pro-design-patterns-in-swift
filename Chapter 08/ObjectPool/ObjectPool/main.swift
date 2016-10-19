import Foundation

var queue = dispatch_queue_create("workQ", DISPATCH_QUEUE_CONCURRENT);
var group = dispatch_group_create();

println("Starting...");

for i in 1 ... 35 {
    dispatch_group_async(group, queue, {() in
        var book = Library.checkoutBook("reader#\(i)");
        if (book != nil) {
            NSThread.sleepForTimeInterval(Double(rand() % 2));
            Library.returnBook(book!);
        } else {
            dispatch_barrier_async(queue, {() in
                println("Request \(i) failed");
            });
        }
    });
}

dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

dispatch_barrier_sync(queue, {() in
    println("All blocks complete");
    Library.printReport();
});
