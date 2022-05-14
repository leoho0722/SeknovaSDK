//
//  CloudParseManager.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/28.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class CloudParseManager: NSObject {
    
    // MARK: SendADC
    
    /// 轉換 CmdType=1 上傳的 JSON Format
    /// - Parameters:
    ///   - input: [SensingRecord]
    /// - Returns: CmdType=1 的 JSON
    public func GetJsonDataReport(input: [SensingRecord]) -> Data? {
        var records: [SDK_SendADCRequest.Records] = []
        var splitRecords: [[SDK_SendADCRequest.Records]] = []
        var apiRecordCountLimit: Int = 144
        
        for i in 0 ..< input.count {
            records.append(SDK_SendADCRequest.Records(RecordTime: (input[i].Timestamp?.timeStampToDate().convert2LocalTZUtcStr())!,
                                                      Value1: input[i].RawData!,
                                                      Value2: input[i].CalibrationData!,
                                                      RSSI: input[i].RSSI!,
                                                      Battery: input[i].Battery!,
                                                      Temperature: Double(input[i].Temperature!),
                                                      IndexID: input[i].IndexID!,
                                                      Calibrated: input[i].isDisplay!))
            splitRecords = []
            splitRecords = records.chunked(by: apiRecordCountLimit)
            
            if records.count > 0 {
                for i in 0 ..< splitRecords.count {
                    var firstRecord = splitRecords[i].min(by: { $0.RecordTime.str2Date().millisecondsSince1970 < $1.RecordTime.str2Date().millisecondsSince1970 })
                    let request = SDK_SendADCRequest(CmdType: 1,
                                                     Status: 1,
                                                     DeviceID: SDK_Setting.shared.deviceID,
                                                     SensorID: SDK_Setting.shared.sensorID,
                                                     FirstRecordDatetime: firstRecord?.RecordTime ?? "error",
                                                     UploadDatetime: getUtcTime(0),
                                                     RecordCount: splitRecords[i].count,
                                                     AdcNumber: 2,
                                                     CheckBit: 0,
                                                     Records: splitRecords[i])
                    let dic1 = try? request.asDictionary()
                    let sendADCJSON = try? JSONSerialization.data(withJSONObject: dic1, options: .prettyPrinted)
//                    exportJson(jsonData: sendADCJSON, fileName: "SendADC_\(i+1)")
                    return sendADCJSON
                }
            }
        }
        return Data()
    }
    
    // MARK: - EventUpload
    
    /// 轉換 CmdType=2 上傳的 JSON Format
    /// - Parameters:
    ///   - input: EventTable
    /// - Returns: CmdType=2 的 JSON
    public func GetJsonEventReport(input: EventTable) -> Data? {
        let dic1: [String: Any] = [
            "CmdType": 2,
            "ID": input.Index,
            "DeviceID": SDK_Setting.shared.deviceID,
            "UserID": SDK_Setting.shared.username,
            "EventID": input.EventID,
            "EventValue": input.EventValue,
            "EventRecordTime": input.TimeStamp?.timeStampToDate().convert2UtcStr(),
            "EventAttribute": input.EventAttribute,
            "Note": input.EventAttribute?.last
        ]
        let eventUploadJSON = try? JSONSerialization.data(withJSONObject: dic1 ?? [:], options: .prettyPrinted)
//        exportJson(jsonData: eventUploadJSON, fileName: "EventUpload")
        return eventUploadJSON
    }
    
    // MARK: - EventDelete
    
    /// 轉換 CmdType=8 (delete event) 上傳的 JSON Format
    /// - Parameters:
    ///   - input: EventTable
    /// - Returns: CmdType=8 的 JSON
    public func GetJsonDeleteEvent(input: EventTable) -> Data? {
        let dic1: [String: Any] = [
            "CmdType": 8,
            "ID": input.Index,
            "UserID": SDK_Setting.shared.username,
            "EventRecordTime": input.TimeStamp?.timeStampToDate().convert2UtcStr()
        ]
        let eventDeleteJSON = try? JSONSerialization.data(withJSONObject: dic1 ?? [:], options: .prettyPrinted)
//        exportJson(jsonData: eventDeleteJSON, fileName: "EventDelete")
        return eventDeleteJSON
    }
    
    // MARK: - AlertReport
    
    /// 轉換 CmdType=0 上傳的 JSON Format
    /// - Parameters:
    ///   - input: AlertTable
    /// - Returns: CmdType=0 的 JSON
    public func GetJsonAlertReport(input: AlertTable) -> Data? {
        let dic1: [String: Any] = [
            "CmdType": 0,
            "UserID": SDK_Setting.shared.username,
            "DeviceID": SDK_Setting.shared.deviceID,
            "EventRecordTime": input.Timestamp?.timeStampToDate().convert2UtcStr(),
            "ErrorCode": input.AlertID,
            "ErrorValue": input.AlertValue
        ]
        let alertTableJSON = try? JSONSerialization.data(withJSONObject: dic1 ?? [:], options: .prettyPrinted)
//        exportJson(jsonData: alertTableJSON, fileName: "AlertUpload")
        return alertTableJSON
    }
    
    // MARK: - PersonalInfo
    
    /// 轉換 CmdType=11 (Add User Info) 上傳的 JSON Format
    /// - Parameters:
    ///   - input: PersonalInfo
    /// - Returns: CmdType=11 的 JSON
    public func GetJsonAddUserInfo(input: PersonalInfo) -> Data? {
        let dic1: [String: Any] = [
            "CmdType": 11,
            "UserID": input.UserID,
            "RecordDate" : Date().convert2CurrectDateStr(),
            "FirstName": input.fname,
            "LastName": input.lname,
            "Email": input.UserID,
            "Address": input.address,
            "Phone": input.phone,
            "Height": input.height,
            "Weight": input.weight,
            "Gender": input.gender,
            "Race": input.ethnic,
            "Birthday": input.birth,
            "Smoke": input.smoke,
            "Liquor": input.drink,
            "PhoneVerified": input.IsPhoneBinding
        ]
        let personalInfoJSON = try? JSONSerialization.data(withJSONObject: dic1 ?? [:], options: .prettyPrinted)
//        exportJson(jsonData: personalInfoJSON, fileName: "AddUserInfo")
        return personalInfoJSON
    }
    
    // MARK: - PersonalDynamicInfo
    
    /// 轉換 CmdType=12 (Add User Dynamic) 上傳的 JSON Format
    /// - Parameters:
    ///   - input: PersonalDynamicInfo
    /// - Returns: CmdType=12 的 JSON
    public func GetJsonAddUserDynamicInfo(input: PersonalDynamicInfo) -> Data? {
        let dic1: [String: Any] = [
            "CmdType" : 12,
            "UserID": input.UserID,
            "RecordDate" : input.Timestamp?.timeStampToDate().convert2CurrectDateStr(),
            "BodyFatPercentage": input.BodyFatPercentage,
            "HbA1c": input.HbA1c,
            "SYS": input.SYS,
            "DIA": input.DIA,
            "TC": input.TC,
            "HDLC": input.HDLC,
            "LDL": input.LDL,
            "Diabetes": input.Diabletes,
            "CRE": input.CRE
        ]
        let personalDynamicInfoJSON = try? JSONSerialization.data(withJSONObject: dic1 ?? [:], options: .prettyPrinted)
//        exportJson(jsonData: personalDynamicInfoJSON, fileName: "AddUserDynamicInfo")
        return personalDynamicInfoJSON
    }
    
    // MARK: - API Response Parse
    
    /// Parse Web API CmdType=13 的 Response JSON
    /// - Parameters:
    ///   - jsonRsp: SDK_GetUserProfileResponse?
    /// - Returns: PersonalInfo 的資料結構，PersonalInfo
    public func ParseRspUserInfo(jsonRsp: SDK_GetUserProfileResponse?) -> PersonalInfo {
        let personalInfo = PersonalInfo()
        personalInfo.UserID = jsonRsp?.UserID
        personalInfo.fname = jsonRsp?.FirstName
        personalInfo.lname = jsonRsp?.LastName
        personalInfo.birth = jsonRsp?.Birthday
        personalInfo.phone = jsonRsp?.Phone
        personalInfo.IsPhoneBinding = (jsonRsp?.PhoneVerified == 1) ? true : false
        personalInfo.address = jsonRsp?.Address
        personalInfo.gender = UInt8((jsonRsp?.Gender)!)
        personalInfo.height = UInt8((jsonRsp?.Height)!)
        personalInfo.weight = UInt8((jsonRsp?.Weight)!)
        personalInfo.ethnic = UInt8((jsonRsp?.Race)!)
        personalInfo.drink = UInt8((jsonRsp?.Liquor)!)
        personalInfo.smoke = (Int((jsonRsp?.Smoke)!) == 1) ? true : false

//        // 下面是用來檢查是否有正確 Parse 成 PersonalInfo
//        print("personalInfo.UserID:: \(personalInfo.UserID)")
//        print("personalInfo.fname:: \(personalInfo.fname)")
//        print("personalInfo.lname:: \(personalInfo.lname)")
//        print("personalInfo.birth:: \(personalInfo.birth)")
//        print("personalInfo.phone:: \(personalInfo.phone)")
//        print("personalInfo.IsPhoneBinding:: \(personalInfo.IsPhoneBinding)")
//        print("personalInfo.address:: \(personalInfo.address)")
//        print("personalInfo.gender:: \(personalInfo.gender)")
//        print("personalInfo.height:: \(personalInfo.height)")
//        print("personalInfo.weight:: \(personalInfo.weight)")
//        print("personalInfo.ethnic:: \(personalInfo.ethnic)")
//        print("personalInfo.drink:: \(personalInfo.drink)")
//        print("personalInfo.smoke:: \(personalInfo.smoke)")
        
        return personalInfo
    }
    
    /// Parse Web API CmdType=27 (Get Event ID) 的 Response JSON
    /// - Parameters:
    ///   - jsonRsp: SDK_GetEventResponse?
    /// - Returns: EventTable 的 array，[EventTable]
    public func ParseRspGetEventsReport(jsonRsp: SDK_GetEventResponse?) -> [EventTable] {
        var eventTableArray = [EventTable]()
        if let eventCount = jsonRsp?.Events?.count {
            for i in 0 ..< eventCount {
                if let id = jsonRsp?.Events?[i].ID, let dateTime = jsonRsp?.Events?[i].DateTime, let eventID = jsonRsp?.Events?[i].EventID, let eventValue = jsonRsp?.Events?[i].EventValue, let eventAttribue = jsonRsp?.Events?[i].EventAttribute {
                    let eventTable = EventTable()
                    eventTable.Index = id
                    eventTable.TimeStamp = Int64(dateTime.shiftUtc2LocalTZ().str2Date().timeIntervalSince1970)
                    eventTable.EventID = eventID
                    eventTable.EventValue = eventValue
                    eventTable.EventAttribute = eventAttribue
                    eventTableArray.append(eventTable)
                } else {
                    print("Parse EventTable Failed！")
                }
            }
        }
        
//        // 下面是用來檢查是否有正確 Parse 成 EventTable
//        print("eventTableArray:: \(eventTableArray)")
//        for i in 0 ..< eventTableArray.count {
//            print("eventTableArray\(i+1):: \(eventTableArray[i])")
//            print("eventTableArray\(i+1)_Index:: \(eventTableArray[i].Index)")
//            print("eventTableArray\(i+1)_TimeStamp:: \(eventTableArray[i].TimeStamp)")
//            print("eventTableArray\(i+1)_DateTime:: \(eventTableArray[i].TimeStamp?.timeStampToDate().convert2UtcStr())")
//            print("eventTableArray\(i+1)_EventID:: \(eventTableArray[i].EventID)")
//            print("eventTableArray\(i+1)_EventValue:: \(eventTableArray[i].EventValue)")
//            print("eventTableArray\(i+1)_EventAttribute:: \(eventTableArray[i].EventAttribute)\n\n")
//        }
        
        return eventTableArray
    }
}

// MARK: - SDK Parse Response Struct

public struct SDK_SendADCRequest: Codable {
    
    var CmdType: Int
    var Status: Int
    var DeviceID: String
    var SensorID: String
    var FirstRecordDatetime: String
    var UploadDatetime: String
    var RecordCount: Int
    var AdcNumber: Int
    var CheckBit: UInt8
    var Records: [Records]
    
    struct Records: Codable {
        var RecordTime: String
        var Value1: [Int]
        var Value2: [Int]
        var RSSI: Int
        var Battery: Int
        var Temperature: Double
        var IndexID: Int
        var Calibrated: Bool
    }
    
}

public struct SDK_GetUserProfileResponse: Decodable {
    
    let CmdRsp: String?
    let UserID: String?
    let code: Int?
    let ErrorMsg: String?
    var RecordDate: String?
    var FirstName: String?
    var LastName: String?
    var Email: String?
    var Address: String?
    var Phone: String?
    var Height: Double?
    var Weight: Double?
    var Gender: String?
    var Race: String?
    var Birthday: String?
    var Smoke: String?
    var Liquor: String?
    var PhoneVerified: Int?
    var Records: [Records]?
    
    struct Records: Decodable {
        var RecordDate: String?
        var BodyFatPercentage: Int?
        var HbA1c: Double?
        var SYS: Int?
        var DIA: Int?
        var TC: Int?
        var HDLC: Int?
        var LDL: Int?
        var Diabetes: String?
        var CRE: Double?
    }
    
}

public struct SDK_GetEventResponse: Decodable {
    
    let CmdRsp: String?
    let Code: Int?
    let ErrorMsg: String?
    var Events: [Events]?
    
    struct Events: Decodable {
        var ID: Int?
        var DateTime: String?
        var EventID: Int?
        var EventValue: Int?
        var EventAttribute: [String]?
        var Note: String?
        var DeviceID: String?
    }
    
}

// MARK: - SDK 內部使用 Function

extension CloudParseManager {
    
    func getUtcTime(_ afterHr: TimeInterval) -> String {
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let after = afterHr * 3600 // hour to second
        let time = Date(timeIntervalSince1970: timeInterval-after)
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy'T'HH:mm:ss"
        dateFormat.timeZone = TimeZone(abbreviation: "UTC")
        let timeString = dateFormat.string(from: time)
        return timeString
    }
    
    func exportJson(jsonData: Data?, fileName: String) {
        if let jsonData = jsonData, let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(fileName)
            print("pathWithFileName:: \(pathWithFileName)")
            do {
                try jsonData.write(to: pathWithFileName)
                print("\(fileName).json Created")
            } catch {
                // handle error
            }
        }
    }
    
}

extension Int64 {
    
    func timeStampToDate() -> Date {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
}

extension Date {
    
    func convert2CurrectDateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
}
