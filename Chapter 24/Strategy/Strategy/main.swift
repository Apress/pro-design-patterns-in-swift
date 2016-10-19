let sequence = Sequence(1, 2, 3, 4);
sequence.addNumber(10);
sequence.addNumber(20);

let sumStrategy = SumStrategy();
let multiplyStrategy = MultiplyStrategy();

let sum = sequence.compute(sumStrategy);
println("Sum: \(sum)");

let multiply = sequence.compute(multiplyStrategy);
println("Multiply: \(multiply)");

let filterThreshold = 10;
let cstrategy = ClosureStrategy({values in
    return values.filter({ $0 < filterThreshold }).reduce(0, {$0 + $1});
});
let filteredSum = sequence.compute(cstrategy);
println("Filtered Sum: \(filteredSum)");
