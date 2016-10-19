import UIKit

class ProductTableCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var product:Product?;
}

var handler = { (p:Product) in
    println("Change: \(p.name) \(p.stockLevel) items in stock");
};

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var productStore = ProductDataStore();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        displayStockTotal();
        let bridge = EventBridge(callback: updateStockLevel);
        productStore.callback = bridge.inputCallback;
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (event.subtype == UIEventSubtype.MotionShake) {
            println("Shake motion detected");
            undoManager?.undo();
        }
    }
    
    func updateStockLevel(name:String, level:Int) {
        for cell in self.tableView.visibleCells() {
            if let pcell = cell as? ProductTableCell {
                if pcell.product?.name == name {
                    pcell.stockStepper.value = Double(level);
                    pcell.stockField.text = String(level);
                }
            }
        }
        self.displayStockTotal();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return productStore.products.count;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let product = productStore.products[indexPath.row];
            let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell")
                as ProductTableCell;
            cell.product = productStore.products[indexPath.row];
            cell.nameLabel.text = product.name;
            cell.descriptionLabel.text = product.productDescription;
            cell.stockStepper.value = Double(product.stockLevel);
            cell.stockField.text = String(product.stockLevel);
            
            CellFormatter.createChain().formatCell(cell);
            
            return cell;
    }
    
    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!;
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product? {
                        
                        let dict = NSDictionary(objects: [product.stockLevel],
                            forKeys: [product.name]);
                        
                        undoManager?.registerUndoWithTarget(self,
                            selector: "undoStockLevel:",
                            object: dict);
                        
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value);
                        } else if let textfield = sender as? UITextField {
                            if let newValue = textfield.text.toInt()? {
                                product.stockLevel = newValue;
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel);
                        cell.stockField.text = String(product.stockLevel);
                        productLogger.logItem(product);
                        
                        StockServerFactory.getStockServer()
                            .setStockLevel(product.name, stockLevel: product.stockLevel);
                    }
                    break;
                }
            }
            displayStockTotal();
        }
    }
    
    func undoStockLevel(data:[String:Int]) {
        let productName = data.keys.first;
        if (productName != nil) {
            let stockLevel = data[productName!];
            if (stockLevel != nil) {
                
                for nproduct in productStore.products {
                    if nproduct.name == productName! {
                        nproduct.stockLevel = stockLevel!;
                    }
                }
                
                updateStockLevel(productName!, level: stockLevel!);
            }
        }
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0),
            {(totals, product) -> (Int, Double) in
                return (
                    totals.0 + product.stockLevel,
                    totals.1 + product.stockValue
                );
        });
        
        let formatted = StockTotalFacade.formatCurrencyAmount(finalTotals.1,
            currency: StockTotalFacade.Currency.EUR);
        
        totalStockLabel.text = "\(finalTotals.0) Products in Stock. "
            + "Total Value: \(formatted!)";
    }
}
