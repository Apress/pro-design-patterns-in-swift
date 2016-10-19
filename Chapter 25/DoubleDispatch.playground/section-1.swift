
protocol MyProtocol {
    
    func dispatch(handler:Handler);
}

class FirstClass : MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self);
    }
}

class SecondClass : MyProtocol {
    func dispatch(handler: Handler) {
        handler.handle(self)
    }
}

class Handler {
    
    func handle(arg:MyProtocol) {
        println("Protocol");
    }
    
    func handle(arg:FirstClass) {
        println("First Class");
    }
    
    func handle(arg:SecondClass) {
        println("Second Class");
    }
}

let objects:[MyProtocol] = [FirstClass(), SecondClass()];
let handler = Handler();

for object in objects {
    object.dispatch(handler);
    //handler.handle(object);
}