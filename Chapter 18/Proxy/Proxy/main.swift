import Foundation;

let url = "http://www.apress.com";
let headers = ["Content-Length", "Content-Encoding"];

let proxy = AccessControlProxy(url: url);

for header in headers {
    proxy.getHeader(header, callback: {header, val in
        if (val != nil) {
            println("\(header): \(val!)");
        }
    });
}

UserAuthentication.sharedInstance.authenticate("bob", pass: "secret");
proxy.execute();

NSFileHandle.fileHandleWithStandardInput().availableData;
