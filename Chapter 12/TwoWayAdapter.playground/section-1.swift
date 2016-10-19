// application

protocol ShapeDrawer {
    func drawShape();
}

class DrawingApp {
    let drawer:ShapeDrawer;
    var cornerRadius:Int = 0;
    
    init(drawer:ShapeDrawer) {
        self.drawer = drawer;
    }
    
    func makePicture() {
        drawer.drawShape();
    }
}

// component library

protocol AppSettings {
    var sketchRoundedShapes:Bool { get };
}

class SketchComponent {
    private let settings:AppSettings;
    
    init(settings:AppSettings) {
        self.settings = settings;
    }
    
    func sketchShape() {
        if (settings.sketchRoundedShapes) {
            println("Sketch Circle");
        } else {
            println("Sketch Square");
        }
    }
}

class TwoWayAdapter : ShapeDrawer, AppSettings {
    var app:DrawingApp?;
    var component:SketchComponent?
    
    func drawShape() {
        component?.sketchShape();
    }
    
    var sketchRoundedShapes: Bool {
        return app?.cornerRadius > 0;
    }
}

let adapter = TwoWayAdapter();
let component = SketchComponent(settings: adapter);
let app = DrawingApp(drawer: adapter);

adapter.app = app;
adapter.component = component;

app.makePicture();
