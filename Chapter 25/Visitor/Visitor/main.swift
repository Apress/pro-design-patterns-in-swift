let shapes = ShapeCollection();
let areaVisitor = AreaVisitor();
shapes.accept(areaVisitor);
println("Area: \(areaVisitor.totalArea)");
println("---");
let edgeVisitor = EdgesVisitor();
shapes.accept(edgeVisitor);
println("Edges: \(edgeVisitor.totalEdges)");
