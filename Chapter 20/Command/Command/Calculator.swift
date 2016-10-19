import Foundation;

class Calculator {
    private(set) var total = 0;
    typealias CommandClosure = (Calculator -> Void);
    private var history = [CommandClosure]();
    private var queue = dispatch_queue_create("arrayQ", DISPATCH_QUEUE_SERIAL);
    
    func add(amount:Int) {
        addMacro(Calculator.add, amount: amount);
        total += amount;
    }
    
    func subtract(amount:Int) {
        addMacro(Calculator.subtract, amount: amount);
        total -= amount;
    }
    
    func multiply(amount:Int) {
        addMacro(Calculator.multiply, amount: amount);
        total = total * amount;
    }
    
    func divide(amount:Int) {
        addMacro(Calculator.divide, amount: amount);
        total = total / amount;
    }
    
    private func addMacro(method:Calculator -> Int -> Void, amount:Int) {
        dispatch_sync(self.queue, {() in
            self.history.append({ calc in  method(calc)(amount)});
        });
    }
    
    func getMacroCommand() -> (Calculator -> Void) {
        var commands = [CommandClosure]();
        dispatch_sync(queue, {() in
            commands = self.history
        });
        return { calc in
            if (commands.count > 0) {
                for index in 0 ..< commands.count {
                    commands[index](calc);
                }
            }
        };
    }
}
