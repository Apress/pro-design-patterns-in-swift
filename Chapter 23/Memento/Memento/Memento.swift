import Foundation

protocol Memento {
    // no methods or properties defined
}

protocol Originator {
    func createMemento() -> Memento;
    func applyMemento(memento:Memento);
}
