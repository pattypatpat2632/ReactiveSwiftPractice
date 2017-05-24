//
//  ViewController.swift
//  ReactiveSwiftPractice
//
//  Created by Patrick O'Leary on 5/23/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clockSignal = Signal<Date, NoError> { (sink) -> Disposable? in
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                print("Tick")
                sink.send(value: Date())
            })
            return SimpleDisposable()
        }
        
        clockSignal.observeValues { (date) in
            print(date)
        }
    }



}

