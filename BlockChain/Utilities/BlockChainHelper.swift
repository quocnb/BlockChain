//
//  BlockChainHelper.swift
//  BlockChain
//
//  Created by Quoc Nguyen on 1/12/18.
//  Copyright © 2018 Quoc Nguyen. All rights reserved.
//

import Foundation

// Thanks to Andreas (https://stackoverflow.com/a/38788437/2776008)
// You must create a Header Bridging File and put the import
// #import <CommonCrypto/CommonHMAC.h>
extension String {
    func sha256() -> String {
        guard let stringData = self.data(using: String.Encoding.utf8) else {
            return ""
        }
        let digest = stringData.sha256()
        return digest.hexString()
    }
}

extension Data {
    func sha256() -> Data {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        self.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(self.count), &hash)
        }
        return Data(bytes: hash)
    }

    func hexString() -> String {
        var bytes = [UInt8](repeating: 0, count: self.count)
        self.copyBytes(to: &bytes, count: self.count)
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
}

extension Int {
    /**
     Find a number p that when hashed with the previous block’s solution a hash with 4 leading 0s is produced. It take to much time for calculator.
     @param: leadingZeroCount. The difficult of the algorithm (4 is sufficient)
     @return: number p
     */
    func proofOfWork(leadingZeroCount: Int) -> Int {
        func validProof(_ proof: Int) -> Bool {
            let string = "\(self)\(proof)"
            let hash = string.sha256()
            return hash.prefix(leadingZeroCount) == String(repeating: "0", count: leadingZeroCount)
        }
        var proof = 0
        while !validProof(proof) {
            proof += 1
        }
        return proof
    }
}
