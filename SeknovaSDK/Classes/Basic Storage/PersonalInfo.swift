//
//  PersonalInfo.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/23.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class PersonalInfo: NSObject, Codable {
    
    public var UserID: String? // 使用者 ID
    public var fname: String? // 姓名：名
    public var lname: String? // 姓名：姓
    public var birth: String? // 生日
    public var phone: String? // 電話
    public var IsPhoneBinding: Bool = false // 電話是否綁定
    public var address: String? // 地址
    public var gender: UInt8? // 性別
    public var height: UInt8? // 身高
    public var weight: UInt8? // 體重
    public var ethnic: UInt8? // 種族
    public var drink: UInt8? // 飲酒程度
    public var smoke: Bool = false // 是否吸菸
    
    public func Validate() -> Bool {
        var isValidate = true
        
        if UserID != nil {
            if PersonalInfo.PersonalInfoValidate.email(UserID!).isRight == false { isValidate = false }
        } else { isValidate = false }
        
        if fname == nil { isValidate = false }
        
        if lname == nil { isValidate = false }
        
        if birth == nil { isValidate = false }
        
        if phone != nil {
            if PersonalInfo.PersonalInfoValidate.phoneNum(phone!).isRight == false { isValidate = false }
        } else { isValidate = false }
        
        if address == nil { isValidate = false }
        
        if gender == nil { isValidate = false }
        
        if height == nil { isValidate = false }
        
        if weight == nil { isValidate = false }
        
        if ethnic == nil { isValidate = false }
        
        if drink == nil { isValidate = false }
        
        return isValidate
    }
    
    enum PersonalInfoValidate {
        case email(_: String)
        case password(_: String)
        case phoneNum(_: String)
        case sixHex(_: String)
        
        var isRight: Bool {
            var predicateStr: String!
            var currObject: String!
            
            switch self {
            case let .email(str):
                predicateStr = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}"
                currObject = str
            case let .password(str):
                predicateStr = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,20}+$"
                currObject = str
            case let .phoneNum(str):
                predicateStr = "[0-9]{9,10}"
                currObject = str
            case let .sixHex(str):
                predicateStr = "^[0-9A-F]{6,}$"
                currObject = str
            }
            
            let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
            return predicate.evaluate(with: currObject)
        }
    }
}
