let ledger = Ledger();

ledger.addEntry("Bob", amount: 100.43);
ledger.addEntry("Joe", amount: 200.20);

let memento = ledger.createMemento();

ledger.applyMemento(memento);

ledger.printEntries();
