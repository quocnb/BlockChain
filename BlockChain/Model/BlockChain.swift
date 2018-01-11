//
//  BlockChain.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/11/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import Foundation

struct BlockChain {

    private var chain: [Block]
    private var currentTransactions: [Transaction]

    init() {
        self.chain = []
        self.currentTransactions = []
    }

    /**
     Create new block
     @param: proof : The proof given by the Proof of Work algorithm
     @param: previousHash: "previous last" block's hash
     */
    mutating func newBlock() {
        let lastBlock = self.lastBlock()
        let index = lastBlock.index + 1
        let prevHash = lastBlock.hash()
        let proof = proofOfWork(lastBlock.proof)
        let trans = self.currentTransactions
        let newBlock = Block(index: index, transaction: trans, prevHash: prevHash, proof: proof)
        self.currentTransactions = []
        self.chain.append(newBlock)
    }

    /**
     Create new transaction
     @param: from : sender id
     @param: to : receiver id
     @param: amount : amount
     @return: index of the block that hold this new transaction
     */
    mutating func newTransaction(_ from: String, to: String, amount: Double) -> Int {
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

    private func proofOfWork(_ prevProof: Int) -> Int {
        return 0
    }
}
