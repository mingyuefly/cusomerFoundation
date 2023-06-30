//
//  MD5Handler.swift
//  md5
//
//  Created by gmy on 2023/6/30.
//

import Foundation
import CommonCrypto

class MD5Handler {
    static func mainBundleMd5() -> String {
        guard let appPath = Bundle.main.resourcePath else { return "" }
        var filePathArr = [String]()
        allFilePath(atPath: appPath, filePaths: &filePathArr)
        var allFilesMd5String: String = ""
        filePathArr.forEach { filePath in
            let fileMd5 = fileMd5String(atPath: filePath)
            if fileMd5.count > 0 {
                allFilesMd5String.append(fileMd5)
                allFilesMd5String.append("|")
            }
        }
        filePathArr.removeAll()
        let md5 = allFilesMd5String.md5String()
        return md5
    }
    
    private static func fileMd5String(atPath path: String) -> String {
        guard let fileHandle = FileHandle(forReadingAtPath: path) else { return "" }
        var done = false
        let ctx = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: MemoryLayout<CC_MD5_CTX>.size)
        CC_MD5_Init(ctx)
        while !done {
            let subData: Data = fileHandle.readData(ofLength: 1024)
            subData.withUnsafeBytes {(bytes: UnsafePointer<CChar>)->Void in
                //Use `bytes` inside this closure
                //...
                CC_MD5_Update(ctx, bytes, CC_LONG(subData.count))
            }
            done = subData.count == 0
        }
        //unsigned char digest[CC_MD5_DIGEST_LENGTH];
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let digest = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5_Final(digest, ctx);
        fileHandle.closeFile()
        
        var hash = ""
        for i in 0..<digestLen {
            hash +=  String(format: "%02x", (digest[i]))
        }
        
        digest.deinitialize(count: digestLen)
        ctx.deinitialize(count: digestLen)
        return hash;
    }
    
    private static func allFilePath(atPath path: String, filePaths dirFileList: inout [String])  {
        var fileNameArr = [String]()
        do {
            fileNameArr = try FileManager.default.contentsOfDirectory(atPath: path)
        } catch {
            print(error)
        }
        for fileName in fileNameArr {
            let fullPath = path + fileName
            var isDirectory: ObjCBool = false
            let exits = FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDirectory)
            if exits && !isDirectory.boolValue {
                if fileName == "CodeResources" || fileName == "ResourceRules.plist" || fileName == "PkgInfo" || fileName.hasSuffix(".mobileprovision") || fileName.hasSuffix(".png") || fileName.hasSuffix(".jpg") || fileName.hasSuffix(".bmp") || fileName.hasSuffix(".aiff") || fileName.hasSuffix(".gif") || fileName.hasSuffix(".mp4") || fileName.hasSuffix(".wav") || fileName.hasSuffix(".appmd5") {
                    continue
                }
                dirFileList.append(fullPath)
            } else {
                if fileName == "_CodeSignature" || fileName == "SC_Info" {
                    continue
                }
                allFilePath(atPath: fullPath, filePaths: &dirFileList)
            }
        }
    }
}
