//: Playground - noun: a place where people can play

import UIKit
@testable import ReactiveSwiftPractice
import ReactiveSwift
import Result

hello()

print("yay")

let sp = SignalProducer<String, NoError>{ (observer, disposable) in
    observer.send(value: "My")
    observer.send(value: "name is")
    observer.send(value: "Pat!")
    observer.sendCompleted()
}
.map { (str) -> String in
    str.uppercased()
}

sp.startWithValues { (value) in
    print(value)
}

let a = [2, 4]
let b = [16, 32, 96]
var count: Int = 0
let bSorted = b.sorted{$0 < $1}
if let max = bSorted.last {
    for num in 1...max{
        var isBetween = true
        for aNum in a {
            if num % aNum != 0 {
                isBetween = false
            }
        }
        for bNum in b {
            if bNum % num != 0 {
                isBetween = false
            }
        }
        if isBetween == true {
            count += 1
        }
    }
}

print(count)