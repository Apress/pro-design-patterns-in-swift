import UIKit;

class CellFormatter {
    var nextLink:CellFormatter?;
    
    func formatCell(cell: ProductTableCell) {
        nextLink?.formatCell(cell);
    }
    
    class func createChain() -> CellFormatter {
        let formatter = ChessFormatter();
        formatter.nextLink = WatersportsFormatter();
        formatter.nextLink?.nextLink = DefaultFormatter();
        return formatter;
    }
}

class ChessFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        if (cell.product?.category == "Chess") {
            cell.backgroundColor = UIColor.lightGrayColor();
        } else {
            super.formatCell(cell);
        }
    }
}

class WatersportsFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        if (cell.product?.category == "Watersports") {
            cell.backgroundColor = UIColor.greenColor();
        } else {
            super.formatCell(cell);
        }
    }
}

class DefaultFormatter : CellFormatter {
    override func formatCell(cell: ProductTableCell) {
        cell.backgroundColor = UIColor.yellowColor();
    }
}
