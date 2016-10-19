import Foundation

final class Library {
    private let pool:Pool<Book>;
    
    private init(stockLevel:Int) {
        
        var stockId = 1;
        
        pool = Pool<Book>(
            itemCount:stockLevel,
            itemFactory: {() in
                return BookSeller.buyBook("Dickens, Charles",
                    title: "Hard Times", stockNumber: stockId++)},
            itemAllocator: {(var books) in
                var selected = 0;
                for index in 1 ..< books.count {
                    if (books[index].checkoutCount < books[selected].checkoutCount) {
                        selected = index;
                    }
                }
                return selected;
            }
        );
    }
    
    private class var singleton:Library {
        struct SingletonWrapper {
            static let singleton = Library(stockLevel:5);
        }
        return SingletonWrapper.singleton;
    }
    
    class func checkoutBook(reader:String) -> Book? {
        var book = singleton.pool.getFromPool();
        book?.reader = reader;
        book?.checkoutCount++;
        return book;
    }
    
    class func returnBook(book:Book) {
        book.reader = nil;
        singleton.pool.returnToPool(book);
    }
    
    class func printReport() {
        singleton.pool.processPoolItems({(books) in
            for book in books {
                println("...Book#\(book.stockNumber)...");
                println("Checked out \(book.checkoutCount) times");
                if (book.reader != nil) {
                    println("Checked out to \(book.reader!)");
                } else {
                    println("In stock");
                }
            }
            println("There are \(books.count) books in the pool");
        });
    }
}
