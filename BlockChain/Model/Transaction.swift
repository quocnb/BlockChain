//
//  Transaction.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/11/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let sender, recipient: String
    let amount: Double
}

extension Transaction {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Transaction.self, from: data) else { return nil }
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
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

