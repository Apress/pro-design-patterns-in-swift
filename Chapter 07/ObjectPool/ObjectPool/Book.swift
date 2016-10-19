class Book {
    let author:String;
    let title:String;
    let stockNumber:Int;
    var reader:String?
    var checkoutCount = 0;
    
    init(author:String, title:String, stock:Int) {
        self.author = author;
        self.title = title;
        self.stockNumber = stock;
    }
}
