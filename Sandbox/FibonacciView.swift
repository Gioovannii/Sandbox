//
//  FibonacciView.swift
//  Sandbox
//
//  Created by Giovanni Gaffé on 2022/2/15.
//

import SwiftUI

func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1
    
    for _ in 0..<number {
        let previous = first
        first = second
        second = previous + first
    }
    
    return first
}

func printFiconacci(of number: Int, allowAbsolute: Bool = false) {
    lazy var result = fibonacci(of: abs(number))
    
    if number < 0 {
        if allowAbsolute {
            print("The result for \(abs(number)) is \(result)")
        } else {
            print("That's not a valid number in the sequence.")
            
        }
    } else {
        print("The result for \(number) is \(result).")
    }
}

func test() {
    printFiconacci(of: 7)
}

struct FibonacciView: View {
    var body: some View {
        Text("Hello")
             .onAppear {
                 test()
             }
    }
}

struct FibonacciView_Previews: PreviewProvider {
    static var previews: some View {
        FibonacciView()
    }
}
