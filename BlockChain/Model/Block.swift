//
//  Block.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/11/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import Foundation

struct Block: Codable {
    let index: Int
    let timestamp: Double
    let transactions: [Transaction]?
    let proof: Int
    let prevHash: String

    enum CodingKeys: String, CodingKey {
        case index, timestamp, transactions, proof
        case prevHash = "previous_hash"
    }

    func hash() -> String {
        guard let json = self.json else {
            fatalError("Must convert to json")
        }
        return json.sha256()
    }

}

extension Block {
    init(index: Int, transaction: [Transaction]?, prevHash: String, proof: Int) {
        self.index = index
        self.transactions = transaction
        self.prevHash = prevHash
        self.timestamp = Date().timeIntervalSince1970
        self.proof = proof
    }

    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Block.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

