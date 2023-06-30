//
//  MD5Extention.swift
//  md5
//
//  Created by gmy on 2023/6/30.
//

import Foundation
import CommonCrypto

extension String {
    func md5String() -> String {
        let data = self.data(using: .utf8)
        return data?.md5Data().hexString() ?? ""
    }
}

extension Data {
    func md5Data() -> Data {
        var da = Data.init(count: Int(CC_MD5_DIGEST_LENGTH))
        let unsafe = [UInt8](self)
        return da.withUnsafeBytes { (bytes) -> Data in
            let b = bytes.baseAddress!.bindMemory(to: UInt8.self, capacity: 4).predecessor()
            let mb = UnsafeMutablePointer(mutating: b)
            CC_MD5(unsafe, CC_LONG(count),mb)
            return da
        }
    }
}
