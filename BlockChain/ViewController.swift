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
        let text = """
{
    "index": 1,
    "timestamp": 1506057125.900785,
    "transactions": [
        {
            "sender": "8527147fe1f5426f9dd545de4b27ee00",
            "recipient": "a77f5cdfa2934df3954a5c7c7da5df1f",
            "amount": 5,
        }
    ],
    "proof": 324984774000,
    "previous_hash": "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"
}
"""
        
        guard let block = Block(text) else {
            print("Parse error")
            return
        }
        let data = block.hash()
        print("Block hash = \(data)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

