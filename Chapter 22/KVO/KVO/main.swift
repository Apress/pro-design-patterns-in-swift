import Foundation;

class Subject : NSObject {
    dynamic var counter = 0;
}

class Observer : NSObject {
    
    init(subject:Subject) {
        super.init();
        subject.addObserver(self, forKeyPath: "counter",
            options: NSKeyValueObservingOptions.New, context: nil);
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject,
        change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
            
            println("Notification: \(keyPath) = \(change[NSKeyValueChangeNewKey]!)");
    }
}

let subject = Subject();
let observer = Observer(subject: subject);
subject.counter++;
subject.counter = 22;
