// create meta observer
let monitor = AttackMonitor();
MetaSubject.sharedInstance.addObservers(monitor);

// create regular observers
let log = ActivityLog();
let cache = FileCache();

let authM = AuthenticationManager();
// register only the regular observers
authM.addObservers(cache, monitor);

authM.authenticate("bob", pass: "secret");
println("-----");
authM.authenticate("joe", pass: "shhh");
