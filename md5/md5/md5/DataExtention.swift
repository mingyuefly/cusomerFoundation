//
//  DataExtention.swift
//  md5
//
//  Created by gmy on 2023/6/30.
//

import Foundation

extension Data {
    func hexString() -> String {
        var t = ""
        let ts = [UInt8](self)
        for one in ts {
            t.append(String.init(format: "%02x", one))
        }
        return t
    }
}
