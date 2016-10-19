import UIKit

class DataSourceStrategy : NSObject, UITableViewDataSource {
    let data:[Printable];
    
    init(_ data:Printable...) {
        self.data = data;
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return data.count;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = UITableViewCell();
            cell.textLabel.text = data[indexPath.row].description;
            return cell;
            
    }
}

let dataSource = DataSourceStrategy("London", "New York", "Paris", "Rome");
let table = UITableView(frame: CGRectMake(0, 0, 400, 200));
table.dataSource = dataSource;
table.reloadData();

// required for display in assistant editor
table;
