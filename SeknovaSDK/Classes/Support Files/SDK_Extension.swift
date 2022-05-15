//
//  Extension.swift
//  Seknova
//
//  Created by 鈞 on 2019/9/17.
//  Copyright © 2019 鈞. All rights reserved.
//

import UIKit
import RealmSwift


//public extension Decimal {
//
//    var doubleValue: Double {
//        return NSDecimalNumber(decimal: self).doubleValue
//    }
//
//    var toString: String {
//        return NSDecimalNumber(decimal: self).stringValue
//    }
//
//}

public extension Data {
    
//    struct HexEncodingOptions: OptionSet {
//        let rawValue: Int
//        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
//    }
    
    struct HexEncodingOptions: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return map { String(format: format, $0) }.joined()
    }
    
    func data2UInt8() -> [UInt8] {
        let uint = Array(self.bytes)
        return uint
    }
    
}

public extension String {
    
//    func replace(target: String, withString: String) -> String {
//        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
//    }
    
//    func hex2ascii() -> String {
//        let example = self
//
//        var chars = [Character]()
//
////        for c in example.characters {
////            chars.append(c)
////        }
//
//        for c in example {
//            chars.append(c)
//        }
//
//        let numbers =  stride(from: 0, to: chars.count, by: 2).map {
//            strtoul(String(chars[$0 ..< $0+2]), nil, 16)
//        }
//
//        var final = ""
//
//        var i = 0
//
//        while i < numbers.count {
//            final.append(Character(UnicodeScalar(Int(numbers[i]))!))
//            i += 1
//        }
//
//        return final
//    }
    
//    func stringValue2HexString(byte: Int) -> String {
//        let str = self
//
//        let data = Data(str.utf8)
//
//        var hexString = data.map{ String(format:"%02x", $0) }.joined()
//
//        while hexString.count < byte * 2 {
//            hexString = "0" + hexString
//        }
//
//        return hexString
//    }
    
    func separatedData(step: Int) -> [String] {
        var myArray : [String] = []
        
        for i in stride(from: 0, to: self.count-1, by: step) {
            let separated = (self as NSString).substring(with: NSMakeRange(i,step))
            myArray.append(separated)
        }
        
        return myArray
    }
    
    func strHex2Int() -> Int {
        let int = Int32(bitPattern: UInt32(self, radix: 16) ?? 0)
        return Int(int)
    }
    
    func strAddZero(count: Int) -> String {
        var newString = self
        
        if self.count < count {
            for _ in 1...count - self.count {
                newString = "0" + newString
            }
        }
        
        return newString
    }
    
//    func strToUInt8() -> Data {
//        var data = Data()
//        data.append(Data(base64Encoded: self)!)
//        return data
//    }
    
//    func str2Double() -> Double {
//        let dateFormat: DateFormatter = DateFormatter()
//        dateFormat.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
//        let date = dateFormat.date(from: self)
//        let time = date?.timeIntervalSince1970
//        return time!
//    }
    
    func str2Date() -> Date {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        let date = dateFormat.date(from: self)
        return date!
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func shiftUtc2LocalTZ() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormat.date(from: self)
        let dateStr = date?.convert2LocalTZUtcStr()
        return dateStr!
    }
    
    func shiftUtc2LocalTZ2() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm:ss"
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormat.date(from: self)
        let dateStr = date?.convert2LocalTZUtcStr()
        return dateStr!
    }
    
    func shiftLocalTZ2Utc() -> String {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        dateFormat.timeZone = TimeZone.autoupdatingCurrent
        let date = dateFormat.date(from: self)
        let dateStr = date?.convert2UtcStr()
        return dateStr!
    }
    
}

public extension Int {
    
    func int2StrHex2() -> String {
        let str = String(format:"%02X", self)
        return str
    }
    
    func int2StrHex4() -> String {
        let str = String(format:"%04X", self)
        return str
    }
    
    func int2StrHex8() -> String {
        let str = String(format:"%08X", self)
        return str
    }
    
    func int2StrHex14() -> String {
        let str = String(format:"%14X", self)
        return str
    }

    func int2StrBinary() -> String {
        let str = String(self, radix: 2)
        return str
    }
    
}

public extension Int64 {
    
    func timeStampToDate() -> Date {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
}

public extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
    
}

public extension Date {
    
//    func daysBetweenDate(Date: Date) -> Int {
//        let components = Calendar.current.dateComponents([.day], from: Date, to: self)
//        return components.day ?? 0
//    }
    
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func convert2CurrectDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func convert2UtcStr() -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dataFormatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        return dataFormatter.string(from: self)
    }
    
    func convert2LocalTZUtcStr() -> String {
        let autoUpdateTimezone = TimeZone.autoupdatingCurrent
        let dataFormatter = DateFormatter()
        dataFormatter.timeZone = autoUpdateTimezone
        dataFormatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        return dataFormatter.string(from: self)
    }
    
    func convert2LocalHex() -> String {
        let autoUpdateTimezone = TimeZone.autoupdatingCurrent
        let dataFormatter = DateFormatter()
        dataFormatter.timeZone = autoUpdateTimezone
        // dataFormatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        dataFormatter.dateFormat = "yyyy"
        let year = Int(dataFormatter.string(from: self))!.int2StrHex4()
        
        dataFormatter.dateFormat = "MM"
        let month = Int(dataFormatter.string(from: self))!.int2StrHex2()
        
        dataFormatter.dateFormat = "dd"
        let day = Int(dataFormatter.string(from: self))!.int2StrHex2()
        
        dataFormatter.dateFormat = "HH"
        let hour = Int(dataFormatter.string(from: self))!.int2StrHex2()
        
        dataFormatter.dateFormat = "mm"
        let min = Int(dataFormatter.string(from: self))!.int2StrHex2()
        
        dataFormatter.dateFormat = "ss"
        let sec = Int(dataFormatter.string(from: self))!.int2StrHex2()
        
        return year+month+day+hour+min+sec
    }
    
    func convert2UtcHex() -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.timeZone = TimeZone(abbreviation: "UTC")
        // dataFormatter.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        dataFormatter.dateFormat = "yyyy"
        let year = Int(dataFormatter.string(from: self))!.int2StrHex4()

        dataFormatter.dateFormat = "MM"
        let month = Int(dataFormatter.string(from: self))!.int2StrHex2()

        dataFormatter.dateFormat = "dd"
        let day = Int(dataFormatter.string(from: self))!.int2StrHex2()

        dataFormatter.dateFormat = "HH"
        let hour = Int(dataFormatter.string(from: self))!.int2StrHex2()

        dataFormatter.dateFormat = "mm"
        let min = Int(dataFormatter.string(from: self))!.int2StrHex2()

        dataFormatter.dateFormat = "ss"
        let sec = Int(dataFormatter.string(from: self))!.int2StrHex2()

        return year+month+day+hour+min+sec
    }
    
}

public extension Array {
    
    func strHexArray2IntArray() -> Array<Int> {
        var myArray : Array<Int> = []
        
        self.forEach {
            let int = Int32(bitPattern: UInt32("\($0)", radix:  16) ?? 0)
            myArray.append(Int(int))
        }
        
        return myArray
    }
    
    func chunked(by chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
    
}

public extension Realm {
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
    
}

public extension Array {
    
    // 刪除陣列裡多筆指定的資料
    mutating func removeSpecifiedIndices(_ indices: [Int]) {
        let sortedIndices = indices.sorted().reversed()
        for i in sortedIndices {
            guard i < count else { return }
            remove(at: i)
        }
    }
    
    // 刪除陣列裡資料 (任何型別)
    mutating func delete(element: AnyObject) {
        self = self.filter() { $0 as AnyObject !== element as AnyObject }
    }
    
}
