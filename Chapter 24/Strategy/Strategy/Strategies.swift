protocol Strategy {
    func execute(values:[Int]) -> Int;
}

class ClosureStrategy : Strategy {
    private let closure:[Int] -> Int;
    
    init(_ closure:[Int] -> Int) {
    self.closure = closure;
    }
    
    func execute(values: [Int]) -> Int {
    return self.closure(values);
    }
}

class SumStrategy: Strategy {
    
    func execute(values: [Int]) -> Int {
        return values.reduce(0, combine: {$0 + $1});
    }
}

class MultiplyStrategy: Strategy {
    
    func execute(values: [Int]) -> Int {
        return values.reduce(1, combine: {$0 * $1});
    }
}
