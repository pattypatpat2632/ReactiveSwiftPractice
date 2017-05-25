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

class ViewController: UITableViewController {
    
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
        testKey()
    }
    
    
    func testKey() {

        let date = String(describing: Date().timeIntervalSince1970)
        let hash = date + marvelPrivateKey + marvelPublicKey
        let md5Data = MD5(string: hash)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        let urlStr = "https://gateway.marvel.com:443/v1/public/events?ts=\(date)&name=infinity&apikey=\(marvelPublicKey)&hash=\(md5Hex)"
        let url = URL(string: urlStr)!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
                print(json)
            } else {
                print(error?.localizedDescription)
            }
        
        }
        task.resume()
    }
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }

    
}

