//
//  TLVUtils.swift
//  Tangem
//
//  Created by Yulia Moskaleva on 28/02/2018.
//  Copyright © 2018 Yulia Moskaleva. All rights reserved.
//

import Foundation




func bytesUsed(_ value:UInt64) -> UInt8{
    let array = value.toByteArray()
    var count:UInt8 = 0
    for byte in array {
        if byte > 0 {
            count += 1
        }
    }
    return count
}

func getLengthData(_ length:Int) -> [UInt8]{
    if(length > 127){
        var result = [UInt8]()
        let byteCount = bytesUsed(UInt64(length))
        let lengthsLength:UInt8 = 0x80 | byteCount;
        result.append(lengthsLength);
        let lengthArray = length.toByteArray();
        for byte in lengthArray {
            if(byte > 0){
                result.append(byte)
            }
        }
        return result;
    }else{
        return [length.toByteArray().last!]
    }
}

func arrayToUInt64(_ data:[UInt8]) -> UInt64?{
    if(data.count > 8){
        return nil;
    }
    let temp = NSData(bytes: data.reversed(), length: data.count)
    //return UnsafePointer<UInt64>(temp.bytes).memory
    let rawPointer = UnsafeRawPointer(temp.bytes)
    let pointer = rawPointer.assumingMemoryBound(to: UInt64.self)
    let value = pointer.pointee
    //print("TLV check 5: \(value)")
    return value
}

func arrayToUInt16(_ data:[UInt8]) -> UInt32?{
 if(data.count > 4){
 return nil;
 }
 let temp = NSData(bytes: data.reversed(), length: data.count)
 let rawPointer = UnsafeRawPointer(temp.bytes)
 let pointer = rawPointer.assumingMemoryBound(to: UInt32.self)
 let value = pointer.pointee
 return value
 }

func cleanHex(hexStr:String) -> String{
    //return hexStr.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<> ")).stringByReplacingOccurrencesOfString(" ", withString: "")
    return hexStr.trimmingCharacters(in: NSCharacterSet(charactersIn: "<> ") as CharacterSet).replacingOccurrences(of: " ", with: "")
}

public func isValidHex(_ asciiHex:String) -> Bool{
    let regex = try! NSRegularExpression(pattern: "^[0-9a-f]*$", options: .caseInsensitive)
    
    let found = regex.firstMatch(in: asciiHex, options: [], range: NSMakeRange(0, asciiHex.count))
    
    if found == nil || found?.range.location == NSNotFound || asciiHex.count % 2 != 0 {
        return false;
    }
    
    return true;
}

public func dataWithHexString(hex: String) -> Data {
    var hex = hex
    var data = Data()
    while(hex.count > 0) {
        let c: String = hex.substring(to: hex.index(hex.startIndex, offsetBy: 2))
        hex = hex.substring(from: hex.index(hex.startIndex, offsetBy: 2))
        var ch: UInt32 = 0
        Scanner(string: c).scanHexInt32(&ch)
        var char = UInt8(ch)
        data.append(&char, count: 1)
    }
    return data
}
//FOR TLV

func arrayToUInt16(_ data:[UInt8]) -> UInt16?{
    if(data.count > 2){
        return nil;
    }
    let temp = NSData(bytes: data.reversed(), length: data.count)
    let rawPointer = UnsafeRawPointer(temp.bytes)
    let pointer = rawPointer.assumingMemoryBound(to: UInt16.self)
    let value = pointer.pointee
    
    return value
}

func sha256(_ data: Data) -> Data? {
    guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { return nil }
    CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
    return res as Data
}

func sha256(_ str: String) -> String? {
    guard
        let data = str.data(using: String.Encoding.utf8),
        let shaData = sha256(data)
        else { return nil }
    let rc = shaData.base64EncodedString(options: [])
    return rc
}

func randomNode()->String{
    let nodes = ["vps.hsmiths.com: 8080","arihancckjge66iv.onion: 8080", "electrumx.bot.nu: 50001", "btc.asis.io: 50001", "e-x.not.fyi: 50001","electrum.backplanedns.org: 50001", "helicarrier.bauerj.eu: 50001"]
    
    let rundomNumber = randRange(lower: 0, upper: nodes.count - 1)
    return nodes[rundomNumber]
}

func randRange (lower: Int , upper: Int) -> Int {
    return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
}
