//
//  ViewController.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/11/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let blockChain = BlockChain.shared
        for _ in 1...10 {
            let newBl = blockChain.newBlock()
            print("Last block hash: \(newBl.prevHash)")
            print("New Block : \(newBl.hash())")
            print("\n\n-----------\n")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

