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

//public extension UIView {
//
//    // 1.File Owner
//    func setViewByOwner<T: UIView>(_ type: T.Type) {
//        let nib = UINib(nibName: String(describing: type), bundle: Bundle.main)
//        let view =  nib.instantiate(withOwner: self, options: nil)[0] as! UIView
//        view.frame = bounds
//        addSubview(view)
//    }
//
//    // 2.View
//    func setViewByNib<T: UIView>(_ type: T.Type) {
//        let objects = Bundle.main.loadNibNamed(String(describing: type), owner: self, options: [:])
//        let view = objects?.first as? T ?? T()
//        view.frame = bounds
//        addSubview(view)
//    }
//
//
//    // 1.File Owner
//    class func getViewByOwner<T: UIView>() -> T {
//        let nib = UINib(nibName: String(describing: self), bundle: Bundle.main)
//        return nib.instantiate(withOwner: self, options: nil)[0] as! T
//    }
//
//    // 2.View
//    class func getViewByNib<T: UIView>() -> T {
//        let objects = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: [:])
//        return objects?.first as? T ?? T()
//    }
//
//    public class func loadFromNib() -> UINib {
//        return UINib(nibName: String(describing: self), bundle: nil)
//    }
//
//    class func fromNib<T: UIView>() -> T {
//        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
//    }
//
//}

//public extension UIBarButtonItem {
//
//    static func addButton(_ target: Any?,
//                          action: Selector,
//                          imageName: String,
//                          size:CGSize = CGSize(width: 28, height: 28),
//                          tintColor:UIColor?) -> UIBarButtonItem {
//        let button = UIButton(type: .system)
//        button.tintColor = tintColor
//        button.setImage(UIImage(named: imageName), for: .normal)
//        button.addTarget(target, action: action, for: .touchUpInside)
//
//        let menuBarItem = UIBarButtonItem(customView: button)
//        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
//        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
//        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
//
//        return menuBarItem
//    }
//
//}

//public extension UILabel {
//
//    func addImage(imageName: String) {
//        let attachment:NSTextAttachment = NSTextAttachment()
//        attachment.image = UIImage(named: imageName)
//
//        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
//        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
//        myString.append(attachmentString)
//
//        self.attributedText = myString
//    }
//
//}

//// MARK: - Extension 鍵盤
//public extension UIViewController {
//
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//}

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

//public enum ButtonEdgeInsetsStyle {
//    // 圖片相對於 label 的位置
//    case Top
//    case Left
//    case Right
//    case Bottom
//}
//
//public extension UITextField {
//
//    open override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
//
//        if #available(iOS 10, *) {
//            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//                return nil
//            }
//        } else {
//            if action == #selector(paste(_:)) {
//                return nil
//            }
//        }
//        return super.target(forAction: action, withSender: sender)
//    }
//
//}

//public extension UIButton {
//
//    func layoutButton(style: ButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
//        // 得到 imageView 和 titleLabel 的寬高
//        let imageWidth = self.imageView?.frame.size.width
//        let imageHeight = self.imageView?.frame.size.height
//
//        var labelWidth: CGFloat! = 0.0
//        var labelHeight: CGFloat! = 0.0
//
//        labelWidth = self.titleLabel?.intrinsicContentSize.width
//        labelHeight = self.titleLabel?.intrinsicContentSize.height
//
//        // 初始化 imageEdgeInsets 和 labelEdgeInsets
//        var imageEdgeInsets = UIEdgeInsets.zero
//        var labelEdgeInsets = UIEdgeInsets.zero
//
//        // 根據 style 和 space 得到 imageEdgeInsets 和 labelEdgeInsets 的值
//        switch style {
//        /**
//            * titleEdgeInsets 是 titleLabel 相對於其上下左右的 inset，跟 tableView 的 contentInset 是類似的；
//            * 如果只有 title，那 titleLabel 的 上下左右 都是 相對於 Button 的；
//            * 如果只有 image，那 imageView 的 上下左右 都是 相對於 Button 的；
//            * 如果同时有 image 和 label，那 image 的 上下左 是 相對於 Button 的，右 是 相對於 label 的；
//            * label 的 上下右 是 相對於 Button 的， 左 是 相對於 label 的。
//             */
//        case .Top:
//            // 上 左 下 右
//            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2, left: 0, bottom: 0, right: -labelWidth)
//            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
//            break;
//
//        case .Left:
//            imageEdgeInsets = UIEdgeInsets(top: 3, left: -imageTitleSpace/2, bottom: 3, right: imageTitleSpace)
//            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2, bottom: 0, right: -imageTitleSpace/2)
//            break;
//
//        case .Bottom:
//            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2, right: -labelWidth)
//            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: 0, right: 0)
//            break;
//
//        case .Right:
//            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2)
//            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2)
//            break;
//        }
//
//        self.titleEdgeInsets = labelEdgeInsets
//        self.imageEdgeInsets = imageEdgeInsets
//
//    }
//}

//public extension UITableView {
//
//    // 根據 TableView 的資料量來設定 TableView 的 Scroll 功能是否開啟
//    /// - Parameters:
//    /// - tableView: 放你要控制的 UITableView
//    /// - isScrollLock: 根據 TableView 的資料量來決定要不要開啟 TableView 的 Scroll 功能，true 是開啟，false 是關閉
//    /// - Returns:不管是 isScrollLock 是 true 還是 false，section 0 的 heightForHeader 都會比其他 section 變高一點點
//    func tableViewScrollLock(tableView: UITableView, isScrollLock: Bool) {
//        tableView.alwaysBounceVertical = isScrollLock
//        tableView.reloadData()
//    }
//
//}

//public extension UIDevice {
//
//    var modelName: String {
//        var systemInfo = utsname()
//        uname(&systemInfo)
//        let machineMirror = Mirror(reflecting: systemInfo.machine)
//        let identifier = machineMirror.children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//
//        switch identifier {
//        case "iPod5,1":                                 return "iPod Touch 5"
//        case "iPod7,1":                                 return "iPod Touch 6"
//        case "iPhone1,1":                               return "iPhone"
//        case "iPhone1,2":                               return "iPhone 3G"
//        case "iPhone2,1":                               return "iPhone 3GS"
//        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
//        case "iPhone4,1":                               return "iPhone 4s"
//        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
//        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
//        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
//        case "iPhone7,2":                               return "iPhone 6"
//        case "iPhone7,1":                               return "iPhone 6 Plus"
//        case "iPhone8,1":                               return "iPhone 6s"
//        case "iPhone8,2":                               return "iPhone 6s Plus"
//        case "iPhone8,4":                               return "iPhone SE 1st generation"
//        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
//        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
//        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
//        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
//        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
//        case "iPhone11,8":                              return "iPhone XR"
//        case "iPhone11,2":                              return "iPhone XS"
//        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
//        case "iPhone12,1":                              return "iPhone 11"
//        case "iPhone12,3":                              return "iPhone 11 Pro"
//        case "iPhone12,5":                              return "iPhone 11 Pro Max"
//        case "iPhone12,8":                              return "iPhone SE 2nd generation"
//        case "iPhone13,1":                              return "iPhone 12 mini"
//        case "iPhone13,2":                              return "iPhone 12"
//        case "iPhone13,3":                              return "iPhone 12 Pro"
//        case "iPhone13,4":                              return "iPhone 12 Pro Max"
//        case "iPhone14,4":                              return "iPhone 13 mini"
//        case "iPhone14,5":                              return "iPhone 13"
//        case "iPhone14,2":                              return "iPhone 13 Pro"
//        case "iPhone14,3":                              return "iPhone 13 Pro Max"
//        case "iPhone14,6":                              return "iPhone SE 3rd generation"
//        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
//        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
//        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
//        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
//        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
//        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
//        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
//        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
//        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
//        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
//        case "AppleTV5,3":                              return "Apple TV"
//        case "i386", "x86_64":                          return "Simulator"
//        default:                                        return identifier
//        }
//    }
//
//    var modelID: String {
//        var systemInfo = utsname()
//        uname(&systemInfo)
//        let machineMirror = Mirror(reflecting: systemInfo.machine)
//        let identifier = machineMirror.children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//        return identifier
//    }
//
//}


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
