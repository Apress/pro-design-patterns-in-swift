import Foundation

class Sum : NSObject, NSCopying {
    let resultsCache: [[Int]];
    var firstValue:Int;
    var secondValue:Int;
    
    init(first:Int, second:Int) {
        resultsCache = [[Int]](count: 10, repeatedValue:
            [Int](count:10, repeatedValue: 0));
        for i in 0..<10 {
            for j in 0..<10 {
                resultsCache[i][j] = i + j;
            }
        }
        self.firstValue = first;
        self.secondValue = second;
    }
    
    private init(first:Int, second:Int, cache:[[Int]]) {
        self.firstValue = first;
        self.secondValue = second;
        resultsCache = cache;
    }
    
    var Result:Int {
        get {
            return firstValue < resultsCache.count
                && secondValue < resultsCache[firstValue].count
                ? resultsCache[firstValue][secondValue]
                : firstValue + secondValue;
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        return Sum(first:self.firstValue,
            second: self.secondValue,
            cache: self.resultsCache);
    }
}

var prototype = Sum(first:0, second:9);
var calc1 = prototype.Result;
var clone = prototype.copy() as Sum;
clone.firstValue = 3; clone.secondValue = 8;
var calc2 = clone.Result;

println("Calc1: \(calc1) Calc2: \(calc2)");
