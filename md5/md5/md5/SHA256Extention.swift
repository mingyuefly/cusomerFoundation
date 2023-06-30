//
//  SHA256Extention.swift
//  md5
//
//  Created by gmy on 2023/6/30.
//

import Foundation
import CommonCrypto
import CryptoKit

extension String {
    func sha256String() -> String {
        let data = self.data(using: .utf8)
        return data?.sha256Data().hexString() ?? ""
    }
}

extension Data {
    func sha256Data() -> Data {
        if #available(iOS 13.0, *) {
            return Data(SHA256.hash(data: self))
        } else {
            // Fallback on earlier versions
            var disest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            self.withUnsafeBytes {
                bytes in
                _ = CC_SHA256(bytes.baseAddress,CC_LONG(self.count),&disest)
            }
            return Data(disest)
        }
    }
}
