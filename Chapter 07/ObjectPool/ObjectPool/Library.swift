import Foundation

final class Library {
    private let books:[Book];
    private let pool:Pool<Book>;
    
    private init(stockLevel:Int) {
        books = [Book]();
        for count in 1 ... stockLevel {
            books.append(Book(author: "Dickens, Charles", title: "Hard Times",
                stock: count))
        }
        pool = Pool<Book>(items:books);
    }
    
    private class var singleton:Library {
        struct SingletonWrapper {
            static let singleton = Library(stockLevel:2);
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
        for book in singleton.books {
            println("...Book#\(book.stockNumber)...");
            println("Checked out \(book.checkoutCount) times");
            if (book.reader != nil) {
                println("Checked out to \(book.reader!)");
            } else {
                println("In stock");
            }
        }
    }
}
