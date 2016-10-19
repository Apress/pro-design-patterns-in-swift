import Foundation;

protocol Shape {
    func accept(visitor:Visitor);
}

protocol Visitor {
    func visit(shape:Circle);
    func visit(shape:Square);
    func visit(shape:Rectangle);
}

class AreaVisitor : Visitor {
    var totalArea:Float = 0;
    
    func visit(shape: Circle) {
        totalArea += (3.14 * powf(shape.radius, 2));
    }
    
    func visit(shape: Square) {
        totalArea += powf(shape.length, 2);
    }
    
    func visit(shape: Rectangle) {
        totalArea += (shape.xLen * shape.yLen);
    }
}

class EdgesVisitor : Visitor {
    var totalEdges = 0;
    
    func visit(shape: Circle) {
        totalEdges += 1;
    }
    
    func visit(shape: Square) {
        totalEdges += 4;
    }
    
    func visit(shape: Rectangle) {
        totalEdges += 4;
    }
}
