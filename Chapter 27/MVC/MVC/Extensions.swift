import Foundation

extension String {
    
    func split() -> [String] {
        return self.componentsSeparatedByCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet())
            .filter({$0 != ""});
    }
}

extension Array {
    
    func unique<T: Equatable>() -> [T] {
        var uniqueValues = [T]();
        
        for value in self {
            if !contains(uniqueValues, value as T) {
                uniqueValues.append(value as T);
            }
        }
        return uniqueValues;
    }
    
    func first<T>(test:T -> Bool) -> T? {
        for value in self {
            if test(value as T) {
                return value as? T;
            }
        }
        return nil;
    }
}
