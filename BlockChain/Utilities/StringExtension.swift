//
//  StringExtension.swift
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
