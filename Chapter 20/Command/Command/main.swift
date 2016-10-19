let calc = Calculator();
calc.add(10);
calc.multiply(4);
calc.subtract(2);
println("Calc 1 Total: \(calc.total)");

let macro = calc.getMacroCommand();

let calc2 = Calculator();
macro(calc2);
println("Calc 2 Total: \(calc2.total)");
