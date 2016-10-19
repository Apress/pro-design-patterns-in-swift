final class Sequence {
    private var numbers:[Int];
    
    init(_ numbers:Int...) {
        self.numbers = numbers;
    }
    
    func addNumber(value:Int) {
        self.numbers.append(value);
    }
    
    func compute(strategy:Strategy) -> Int {
        return strategy.execute(self.numbers);
    }
}
