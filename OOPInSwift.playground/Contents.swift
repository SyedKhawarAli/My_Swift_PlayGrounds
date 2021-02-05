
// MARK: - Overloading and overriding

class Shape {
    func printSides(width: Int, height: Int) {
        print("\(width) : \(height)")
    }

    func printTest() {
        print("Testign parent")
    }

    func printSides(width: Double, height: Double) {
        print("\(width) : \(height)")
    }
}

class Rect: Shape {
    override func printSides(width: Int, height: Int) {
        super.printSides(width: width, height: height)
        print("Printing from child")
    }

    override func printTest() {
        print("Testing child")
    }
}

let rect = Rect()
rect.printSides(width: 4, height: 5)
rect.printSides(width: 3.5, height: 5.2)
// rect.printTest()

// MARK: - Polymorphism

protocol ShapeInterface {
    func area() -> Double
}

class Rect2: ShapeInterface {
    let width, height: Double

    init(w: Double, h: Double) {
        width = w
        height = h
    }

    func area() -> Double {
        return width * height
    }
}

class Square: ShapeInterface {
    let width: Double

    init(w: Double) {
        width = w
    }

    func area() -> Double {
        return width * width
    }
}

class Triangle: ShapeInterface {
    let base, vertical, hypotinuse: Double

    init(b: Double, v: Double, h: Double) {
        base = b
        vertical = v
        hypotinuse = h
    }

    func area() -> Double {
        return (base * vertical) / 2
    }
}

class GetShape {
    let shape: ShapeInterface

    init(s: ShapeInterface) {
        shape = s
    }

    func printArea() {
        print(shape.area())
    }
}

let rect2 = Rect2(w: 2, h: 4)
let square = Square(w: 5)
let triangle = Triangle(b: 5, v: 3, h: 6)
let getShape = GetShape(s: triangle)
getShape.printArea()

// MARK: - Encapsulation

class A {
    func g() {
        print("A")
    }

    func h() {
        print("A")
    }
}

class B: A {
    override func h() {
        print("B")
    }

    func f() {
        print("B")
    }
}

let a1 = A()
// let a2: B = A()
let b1: A = B()
let b2 = B()

// a1.g() //A
// a1.h() //A
// a1.f() //error

// a2.g() //error
// a2.h() //error
// a2.f() //error

// b1.g()//A
// b1.h()//B
// b1.f()//error

// b2.g()//A
// b2.h()//B
// b2.f()//B
