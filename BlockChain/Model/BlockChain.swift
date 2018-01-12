//
//  BlockChain.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/11/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import Foundation

class BlockChain {

    static let shared = BlockChain()

    private let difficult = 3

    private var chain: [Block]
    private var currentTransactions: [Transaction]
    init() {
        self.chain = []
        self.currentTransactions = []
        createInitializeBlock()
    }

    private func createInitializeBlock() {
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
            fatalError("No initialize block")
        }
        self.chain.append(block)
    }

    /**
     Create new block
     @param: proof : The proof given by the Proof of Work algorithm
     @param: previousHash: "previous last" block's hash
     */
    func newBlock() -> Block {
        let lastBlock = self.lastBlock()
        let index = lastBlock.index + 1
        let prevHash = lastBlock.hash()
        let proof = lastBlock.proof.proofOfWork(leadingZeroCount: difficult)
        let trans = self.currentTransactions
        let newBlock = Block(index: index, transaction: trans, prevHash: prevHash, proof: proof)
        self.currentTransactions = []
        self.chain.append(newBlock)
        return newBlock
    }

    /**
     Create new transaction
     @param: from : sender id
     @param: to : receiver id
     @param: amount : amount
     @return: index of the block that hold this new transaction
     */
    func newTransaction(_ from: String, to: String, amount: Double) -> Int {
        let newTran = Transaction(sender: from, recipient: to, amount: amount)
        self.currentTransactions.append(newTran)
        return self.lastBlock().index + 1
    }

    private func lastBlock() -> Block {
        guard let last = self.chain.last else {
            fatalError("Must have last block")
        }
        return last
    }

}
