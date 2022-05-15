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
        let apiRecordCountLimit: Int = 144
        
        for i in 0 ..< input.count {
            records.append(SDK_SendADCRequest.Records(RecordTime: (input[i].Timestamp?.timeStampToDate().convert2LocalTZUtcStr())!,
                                                      Value1: input[i].RawData!,
                                                      Value2: input[i].CalibrationData!,
                                                      RSSI: input[i].RSSI!,
                                                      Battery: input[i].Battery!,
                                                      Temperature: Double(input[i].Temperature!),
                                                      IndexID: input[i].IndexID!,
                                                      Calibrated: input[i].isDisplay))
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
        personalInfo.gender = Int((jsonRsp?.Gender)!)
        personalInfo.height = Int((jsonRsp?.Height)!)
        personalInfo.weight = Int((jsonRsp?.Weight)!)
        personalInfo.ethnic = Int((jsonRsp?.Race)!)
        personalInfo.drink = Int((jsonRsp?.Liquor)!)
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
    
    public var CmdType: Int
    public var Status: Int
    public var DeviceID: String
    public var SensorID: String
    public var FirstRecordDatetime: String
    public var UploadDatetime: String
    public var RecordCount: Int
    public var AdcNumber: Int
    public var CheckBit: UInt8
    public var Records: [Records]
    
    public struct Records: Codable {
        public var RecordTime: String
        public var Value1: [Int]
        public var Value2: [Int]
        public var RSSI: Int
        public var Battery: Int
        public var Temperature: Double
        public var IndexID: Int
        public var Calibrated: Bool
    }
    
}

public struct SDK_GetUserProfileResponse: Decodable {
    
    public let CmdRsp: String?
    public let UserID: String?
    public let code: Int?
    public let ErrorMsg: String?
    public var RecordDate: String?
    public var FirstName: String?
    public var LastName: String?
    public var Email: String?
    public var Address: String?
    public var Phone: String?
    public var Height: Double?
    public var Weight: Double?
    public var Gender: String?
    public var Race: String?
    public var Birthday: String?
    public var Smoke: String?
    public var Liquor: String?
    public var PhoneVerified: Int?
    public var Records: [Records]?
    
    public struct Records: Decodable {
        public var RecordDate: String?
        public var BodyFatPercentage: Int?
        public var HbA1c: Double?
        public var SYS: Int?
        public var DIA: Int?
        public var TC: Int?
        public var HDLC: Int?
        public var LDL: Int?
        public var Diabetes: String?
        public var CRE: Double?
    }
    
}

public struct SDK_GetEventResponse: Decodable {
    
    public let CmdRsp: String?
    public let Code: Int?
    public let ErrorMsg: String?
    public var Events: [Events]?
    
    public struct Events: Decodable {
        public var ID: Int?
        public var DateTime: String?
        public var EventID: Int?
        public var EventValue: Int?
        public var EventAttribute: [String]?
        public var Note: String?
        public var DeviceID: String?
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
