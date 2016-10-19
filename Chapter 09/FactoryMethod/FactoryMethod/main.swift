import Foundation

let passengers = [1, 3, 5];

for p in passengers {
    println("\(p) passengers: \(CarSelector.selectCar(p)!)");
}