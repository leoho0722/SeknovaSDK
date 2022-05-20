//
//  LocalDatabase.swift
//  Seknova
//
//  Created by 鈞 on 2020/1/9.
//  Copyright © 2020 鈞. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalDatabase: NSObject {
    
    public static let shared = LocalDatabase()
    
//    func addRecordData(Count: Int,
//                       RecordTime: String,
//                       DisplayTime: String,
//                       Temperature: Int,
//                       ADC1: Int,
//                       ADC2: Int,
//                       RawData: Int,
//                       RSSI: Int,
//                       Battery: Int,
//                       Check: Bool,
//                       Calibrated: Bool){
//        let realm = try! Realm()
//        let lastRecords = realm.objects(Records.self).filter("RecordTime = %s OR ADC2 = %s", RecordTime, ADC2)
//        if lastRecords.count == 0 {
//            let records = Records()
//            records.Count = Count
//            records.RecordTime = RecordTime
//            records.DisplayTime = DisplayTime
//            records.Temperature = Temperature
//            records.ADC1 = ADC1
//            records.ADC2 = ADC2
//            records.RawData = RawData
//            records.RSSI = RSSI
//            records.Battery = Battery
//            records.Check = Check
//            records.Calibrated = Calibrated
//            try! realm.write {
//                realm.add(records)
//            }
//            let time = CommandBase.shareInstance.dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
//            LocalDatabase.shared.addLogsData(Log: "\(time) Realm DB Insert Record Index =  \(ADC2)", time: time )
//        }else{
//            let time = CommandBase.shareInstance.dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
//            LocalDatabase.shared.addLogsData(Log: "\(time) Realm DB Records Duplicate T =  \(RecordTime)", time: time )
//        }
//    }
//    func addEventData(Id: Int,
//                      DateTime: String,
//                      DisplayTime: String,
//                      EventID: Int,
//                      EventValue: Int,
//                      EventAttribute: List<String>,
//                      Note: String,
//                      Check: Bool) {
//        let realm = try! Realm()
//        let lastRecords = realm.objects(EventData.self).filter("DateTime = %s",DateTime)
//        if lastRecords.count == 0 {
//            let eventData = EventData()
//            eventData.Id = Id
//            eventData.DateTime = DateTime
//            eventData.DisplayTime = DisplayTime
//            eventData.EventID = EventID
//            eventData.EventValue = EventValue
//            eventData.EventAttribute = EventAttribute
//            eventData.Note = Note
//            eventData.Check = Check
////            try! realm.write {
////                realm.add(eventData)
////            }
//            do {
//                try! realm.write {
//                    realm.add(eventData)
//                }
//            } catch let error as NSError {
//                print("Realm Error: \(error)")
//            }
//        }else{
//            print("erjoiwejriojweoirr")
//        }
//    }
//    func addAlertData(ErrorCode: Int,
//                      ErrorValue: Int,
//                      RecordTime: String,
//                      Check: Bool){
//        let realm = try! Realm()
//        let lastRecords = realm.objects(AlertData.self).filter("RecordTime = %s",RecordTime)
//        if lastRecords.count == 0 {
//            let alertData = AlertData()
//            alertData.ErrorCode = ErrorCode
//            alertData.ErrorValue = ErrorValue
//            alertData.RecordTime = RecordTime
//            alertData.Check = Check
//            try! realm.write {
//                realm.add(alertData)
//            }
//        }
//    }
//    func addLogsData(Log: String,time:String){
//        let realm = try! Realm()
//        let lastRecords = realm.objects(LogsData.self).filter("Log = %s",Log)
//        if lastRecords.count == 0 {
//            let logData = LogsData()
//            logData.Log = Log
//            logData.RecordTime = time
//            try! realm.safeWrite {
//                realm.add(logData)
//            }
//        }
//    }
//    func addPersonalInfoData(UserID: String,
//                             FirstName: String,
//                             LastName: String,
//                             Birthday: String,
//                             Email: String,
//                             Phone: String = "",
//                             Address: String = "",
//                             Gender: Int,
//                             Height: Int,
//                             Weight: Int,
//                             Race: Int,
//                             Liquor: Int,
//                             Smoke: Bool,
//                             Phone_Verified: Int,
//                             Check: Bool){
//        let realm = try! Realm()
//        let lastRecords = realm.objects(UserInformation.self).filter("UserID = %s",UserID)
//        if lastRecords.count == 0 {
//            let infoData = UserInformation()
//            infoData.UserID = UserID
//            infoData.FirstName = FirstName
//            infoData.LastName = LastName
//            infoData.Birthday = Birthday
//            infoData.Email = Email
//            infoData.Phone = Phone
//            infoData.Address = Address
//            infoData.Gender = Gender
//            infoData.Height = Height
//            infoData.Weight = Weight
//            infoData.Race = Race
//            infoData.Liquor = Liquor
//            infoData.Smoke = Smoke
//            infoData.Phone_Verified = Phone_Verified
//            infoData.Check = Check
//            try! realm.safeWrite {
//                realm.add(infoData)
//            }
//        }
//    }
    
//    func addCalibrationModeData(ModeID: Int,
//                                RawData2BGBias: Int,
//                                BGBias: Int,
//                                BGLow: Int,
//                                BGHigh: Int,
//                                MapRate: String,
//                                ThresholdRise: String,
//                                ThresholdFall: String,
//                                RiseRate: String,
//                                FallenRate: String) {
//        let realm = try! Realm()
//        let calibrationMode = CalibrationMode()
//        if (SDK_Setting.shared.isFirstLogin) { print("使用者首次登入") }
//        calibrationMode.ModeID = ModeID
//        calibrationMode.RawData2BGBias = RawData2BGBias
//        calibrationMode.BGBias = BGBias
//        calibrationMode.BGLow = BGLow
//        calibrationMode.BGHigh = BGHigh
//        calibrationMode.MapRate = MapRate
//        calibrationMode.ThresholdRise = ThresholdRise
//        calibrationMode.ThresholdFall = ThresholdFall
//        calibrationMode.RiseRate = RiseRate
//        calibrationMode.FallenRate = FallenRate
//        try! realm.write {
//            realm.add(calibrationMode)
//            print("存檔完成")
//        }
//        print("File URL:\(realm.configuration.fileURL!)")
//    }
    
//    func saveCalibrationModeData(ModeID: Int,
//                                 RawData2BGBias: Int,
//                                 BGBias: Int,
//                                 BGLow: Int,
//                                 BGHigh: Int,
//                                 MapRate: String,
//                                 ThresholdRise: String,
//                                 ThresholdFall: String,
//                                 RiseRate: String,
//                                 FallenRate: String,
//                                 showAlert: Bool,
//                                 vc: UIViewController) {
//        let realm = try! Realm()
//        let calibrationModeResults = realm.objects(CalibrationMode.self)
//        if (calibrationModeResults.count != 0) {
//            try! realm.write {
//                print("開始複寫原檔")
//                calibrationModeResults[0].ModeID = ModeID
//                calibrationModeResults[0].RawData2BGBias = RawData2BGBias
//                calibrationModeResults[0].BGBias = BGBias
//                calibrationModeResults[0].BGLow = BGLow
//                calibrationModeResults[0].BGHigh = BGHigh
//                calibrationModeResults[0].MapRate = MapRate
//                calibrationModeResults[0].ThresholdRise = ThresholdRise
//                calibrationModeResults[0].ThresholdFall = ThresholdFall
//                calibrationModeResults[0].RiseRate = RiseRate
//                calibrationModeResults[0].FallenRate = FallenRate
//                print("更新完成")
//            }
//            if (showAlert == true) {
//                TAlertView.showAlertWith(title: nil, message: NSLocalizedString("Save", comment: "") + NSLocalizedString("Success", comment: ""), delegate: vc, confirm: nil)
//            }
//        }
//        print("File URL:\(realm.configuration.fileURL!)")
//    }
    
//    func saveRecordCountData(){
//        let realm = try! Realm()
//        let results = realm.objects(UserInformation.self).filter("UserID == %s",SDK_Setting.shared.username)
//        try! realm.write {
//            results[0].lastRecordCount = SDK_Setting.shared.lastRecordCount
//            results[0].firstRecordCount = SDK_Setting.shared.firstRecordCount
//            results[0].resetCount = SDK_Setting.shared.resetCount
//        }
//    }
//
//    func deleteRecordData(){
//        let realm = try! Realm()
//        let resultRecords = realm.objects(Records.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultRecords)
//        }
//    }
//    func deleteEventData(){
//        let realm = try! Realm()
//        let resultEvent = realm.objects(EventData.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultEvent)
//        }
//    }
//    func deleteAlertData(){
//        let realm = try! Realm()
//        let resultAlert = realm.objects(AlertData.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultAlert)
//        }
//    }
//    func deleteLogsData(){
//        let realm = try! Realm()
//        let resultLog = realm.objects(LogsData.self)
//        try! realm.write {
//            realm.delete(resultLog)
//        }
//    }
//    func deleteAllData(){
//        let realm = try! Realm()
//        let resultRecords = realm.objects(Records.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultRecords)
//        }
//        let resultEvent = realm.objects(EventData.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultEvent)
//        }
//        let resultAlert = realm.objects(AlertData.self).filter("Check = YES")
//        try! realm.write {
//            realm.delete(resultAlert)
//        }
//        let resultLog = realm.objects(LogsData.self)
//        try! realm.write {
//            realm.delete(resultLog)
//        }
////        try! realm.write {
////            deleteRecordData()
////            deleteEventData()
////            deleteAlertData()
////            deleteLogsData()
////            realm.deleteAll()
////        }
//    }
//    func changeRecordDisplayTime(){
//        let realm = try! Realm()
//        let refresh = realm.objects(Records.self)
//        try! realm.safeWrite {
//            print("修改 ADC Record")
//            refresh.forEach { (result) in
//                print("Index:\(result.ADC2), \(result.DisplayTime) -> \(result.RecordTime.shiftUtc2LocalTZ())")
//                result.DisplayTime = result.RecordTime.shiftUtc2LocalTZ()
//            }
//        }
//        let refresh2 = realm.objects(EventData.self)
//        try! realm.safeWrite {
//            print("修改 Event Record")
//            refresh2.forEach { (result2) in
//                print("\(result2.DateTime) -> \(result2.DateTime.shiftUtc2LocalTZ())")
//                result2.DisplayTime = result2.DateTime.shiftUtc2LocalTZ()
//            }
//        }
//        SDK_Setting.shared.lastTimeZoneNumber = TimeZone.autoupdatingCurrent.secondsFromGMT() / 3600
//    }
}

public class Records: Object {
    @objc public dynamic var Count = 0
    @objc public dynamic var RecordTime = ""
    @objc public dynamic var DisplayTime = ""
    @objc public dynamic var Temperature = 0
    @objc public dynamic var ADC1 = 0
    @objc public dynamic var ADC2 = 0
    @objc public dynamic var RawData = 0
    @objc public dynamic var RSSI = 0
    @objc public dynamic var Battery = 0
    @objc public dynamic var Check = false
    @objc public dynamic var Calibrated = false
}

public class EventData: Object {
    @objc public dynamic var Id = 0
    @objc public dynamic var DateTime = ""
    @objc public dynamic var DisplayTime = ""
    @objc public dynamic var EventID = 0
    @objc public dynamic var EventValue = 0
    public var EventAttribute = List<String>()
    @objc public dynamic var Note = ""
    @objc public dynamic var Check = false
}

public class AlertData: Object {
    @objc public dynamic var ErrorCode = 0
    @objc public dynamic var ErrorValue = 0
    @objc public dynamic var RecordTime = ""
    @objc public dynamic var Check = false
}

public class LogsData: Object {
    @objc public dynamic var Log = ""
    @objc public dynamic var RecordTime = ""
}

public class UserInformation: Object {
    @objc public dynamic var UserID = ""
    @objc public dynamic var FirstName = ""
    @objc public dynamic var LastName = ""
    @objc public dynamic var Birthday = ""
    @objc public dynamic var Email = ""
    @objc public dynamic var Phone = ""
    @objc public dynamic var Address = ""
    @objc public dynamic var Gender = 0
    @objc public dynamic var Height = 0
    @objc public dynamic var Weight = 0
    @objc public dynamic var Race = 0
    @objc public dynamic var Liquor = 0
    @objc public dynamic var Smoke = false
    @objc public dynamic var Check = false
    @objc public dynamic var Phone_Verified = 0
    @objc public dynamic var finishCalibrateTime: Int64 = 0 // 用來當寫入的時間，timeStamp
    @objc public dynamic var nextCalibrateInterval: Int64 = 0 // 用來當下次要校正的時間 (換算成秒數)，間隔
    @objc public dynamic var lastRecordCount = "00000000"
    @objc public dynamic var firstRecordCount = "00000000"
    @objc public dynamic var resetCount = 0
    
    public override static func primaryKey() -> String? {
        return "UserID"
    }
}

// 設定 -> 校正模式 LocalDB
public class CalibrationMode: Object {
    @objc public dynamic var ModeID: Int = 0
    @objc public dynamic var RawData2BGBias: Int = 0
    @objc public dynamic var BGBias: Int = 0
    @objc public dynamic var BGLow: Int = 0
    @objc public dynamic var BGHigh: Int = 0
    @objc public dynamic var MapRate = ""
    @objc public dynamic var ThresholdRise = ""
    @objc public dynamic var ThresholdFall = ""
    @objc public dynamic var RiseRate = ""
    @objc public dynamic var FallenRate = ""
}

// MARK: - LocalDatabaseDelegate

extension LocalDatabase: LocalDatabaseDelegate {
    
    public func AddRecord(Count: Int,
                   RecordTime: String,
                   DisplayTime: String,
                   Temperature: Int,
                   ADC1: Int,
                   ADC2: Int,
                   RawData: Int,
                   RSSI: Int,
                   Battery: Int,
                   Check: Bool,
                   Calibrated: Bool) {
        let realm = try! Realm()
        let lastRecords = realm.objects(Records.self).filter("RecordTime = %s", RecordTime, ADC2)
        if (lastRecords.count == 0) {
            let records = Records()
            records.Count = Count
            records.RecordTime = RecordTime
            records.DisplayTime = DisplayTime
            records.Temperature = Temperature
            records.ADC1 = ADC1
            records.ADC2 = ADC2
            records.RawData = RawData
            records.RSSI = RSSI
            records.Battery = Battery
            records.Check = Check
            records.Calibrated = Calibrated
            try! realm.write {
                realm.add(records)
            }
            let time = dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
            LocalDatabase.shared.addLogsData(Log: "\(time) Realm DB Insert Record Index =  \(ADC2)", time: time )
        } else {
            let time = dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
            LocalDatabase.shared.addLogsData(Log: "\(time) Realm DB Records Duplicate T =  \(RecordTime)", time: time )
        }
    }
    
    public func AddEvent(Id: Int,
                  DateTime: String,
                  DisplayTime: String,
                  EventID: Int,
                  EventValue: Int,
                  EventAttribute: [String],
                  Note: String,
                  Check: Bool) {
        let realm = try! Realm()
        let lastRecords = realm.objects(EventData.self).filter("DateTime = %s", DateTime)
        if (lastRecords.count == 0) {
            let listEventAttribute = List<String>()
            listEventAttribute.removeAll()
            for i in 0 ..< EventAttribute.count {
                listEventAttribute.append(EventAttribute[i])
            }
            let eventData = EventData()
            eventData.Id = Id
            eventData.DateTime = DateTime
            eventData.DisplayTime = DisplayTime
            eventData.EventID = EventID
            eventData.EventValue = EventValue
            eventData.EventAttribute = listEventAttribute
            eventData.Note = Note
            eventData.Check = Check
            
            do {
                try! realm.write {
                    realm.add(eventData)
                }
            } catch let error as NSError {
                print("Realm Error: \(error)")
            }
        } else {
            print("addEventData lastRecords.count != 0")
        }
    }
    
    public func AddAlert(ErrorCode: Int, ErrorValue: Int, RecordTime: String, Check: Bool) {
        let realm = try! Realm()
        let lastRecords = realm.objects(AlertData.self).filter("RecordTime = %s", RecordTime)
        if (lastRecords.count == 0) {
            let alertData = AlertData()
            alertData.ErrorCode = ErrorCode
            alertData.ErrorValue = ErrorValue
            alertData.RecordTime = RecordTime
            alertData.Check = Check
            try! realm.write {
                realm.add(alertData)
            }
        }
    }
    
    public func addLogsData(Log: String, time: String) {
        let realm = try! Realm()
        let lastRecords = realm.objects(LogsData.self).filter("Log = %s", Log)
        if (lastRecords.count == 0) {
            let logData = LogsData()
            logData.Log = Log
            logData.RecordTime = time
            try! realm.safeWrite {
                realm.add(logData)
            }
        }
    }
    
    public func AddPersonalInfo(UserID: String,
                         FirstName: String,
                         LastName: String,
                         Birthday: String,
                         Email: String,
                         Phone: String = "",
                         Address: String = "",
                         Gender: Int,
                         Height: Int,
                         Weight: Int,
                         Race: Int,
                         Liquor: Int,
                         Smoke: Bool,
                         Phone_Verified: Int,
                         Check: Bool) {
        let realm = try! Realm()
        let lastRecords = realm.objects(UserInformation.self).filter("UserID = %s", UserID)
        if (lastRecords.count == 0) {
            let infoData = UserInformation()
            infoData.UserID = UserID
            infoData.FirstName = FirstName
            infoData.LastName = LastName
            infoData.Birthday = Birthday
            infoData.Email = Email
            infoData.Phone = Phone
            infoData.Address = Address
            infoData.Gender = Gender
            infoData.Height = Height
            infoData.Weight = Weight
            infoData.Race = Race
            infoData.Liquor = Liquor
            infoData.Smoke = Smoke
            infoData.Phone_Verified = Phone_Verified
            infoData.Check = Check
            try! realm.safeWrite {
                realm.add(infoData)
            }
        }
    }
    
    public func UpdateGlucoseCorrectParam(ModeID: Int,
                                   RawData2BGBias: Int,
                                   BGBias: Int,
                                   BGLow: Int,
                                   BGHigh: Int,
                                   MapRate: String,
                                   ThresholdRise: String,
                                   ThresholdFall: String,
                                   RiseRate: String,
                                   FallenRate: String,
                                   finish: (() -> Void)?) {
        let realm = try! Realm()
        let calibrationModeResults = realm.objects(CalibrationMode.self)
        if (calibrationModeResults.count > 0) {
            try! realm.write {
                print("開始複寫原檔")
                calibrationModeResults[0].ModeID = ModeID
                calibrationModeResults[0].RawData2BGBias = RawData2BGBias
                calibrationModeResults[0].BGBias = BGBias
                calibrationModeResults[0].BGLow = BGLow
                calibrationModeResults[0].BGHigh = BGHigh
                calibrationModeResults[0].MapRate = MapRate
                calibrationModeResults[0].ThresholdRise = ThresholdRise
                calibrationModeResults[0].ThresholdFall = ThresholdFall
                calibrationModeResults[0].RiseRate = RiseRate
                calibrationModeResults[0].FallenRate = FallenRate
                print("更新完成")
            }
            print("File URL:\(realm.configuration.fileURL!)")
            
            let param = GlucoseCorrectParam()
            param.RawData2BGBias = RawData2BGBias
            param.BGBias = BGBias
            param.BGLow = BGLow
            param.BGHigh = BGHigh
            param.MapRate = Int(MapRate)!
            param.ThresholdRise = Int(Double(ThresholdRise)!)
            param.ThresholdFall = Int(Double(ThresholdFall)!)
            param.RiseRate = Int(Double(RiseRate)!)
            param.FallenRate = Int(Double(FallenRate)!)
            DataCorrectionAlgo.share.UpdateAlgoParam(param: param)
            
            finish?()
            
        } else {
            if (SDK_Setting.shared.isFirstLogin) { print("使用者首次登入") }
            
            let calibrationMode = CalibrationMode()
            calibrationMode.ModeID = ModeID
            calibrationMode.RawData2BGBias = RawData2BGBias
            calibrationMode.BGBias = BGBias
            calibrationMode.BGLow = BGLow
            calibrationMode.BGHigh = BGHigh
            calibrationMode.MapRate = MapRate
            calibrationMode.ThresholdRise = ThresholdRise
            calibrationMode.ThresholdFall = ThresholdFall
            calibrationMode.RiseRate = RiseRate
            calibrationMode.FallenRate = FallenRate
            
            try! realm.write {
                realm.add(calibrationMode)
                print("存檔完成")
            }
            print("File URL:\(realm.configuration.fileURL!)")
        
            let param = GlucoseCorrectParam()
            param.RawData2BGBias = RawData2BGBias
            param.BGBias = BGBias
            param.BGLow = BGLow
            param.BGHigh = BGHigh
            param.MapRate = Int(MapRate)!
            param.ThresholdRise = Int(ThresholdRise)!
            param.ThresholdFall = Int(ThresholdFall)!
            param.RiseRate = Int(RiseRate)!
            param.FallenRate = Int(FallenRate)!
            DataCorrectionAlgo.share.UpdateAlgoParam(param: param)
        }
    }
    
    public func saveRecordCountData() {
        let realm = try! Realm()
        let results = realm.objects(UserInformation.self).filter("UserID == %s", SDK_Setting.shared.username)
        try! realm.write {
            results[0].lastRecordCount = SDK_Setting.shared.lastRecordCount
            results[0].firstRecordCount = SDK_Setting.shared.firstRecordCount
            results[0].resetCount = SDK_Setting.shared.resetCount
        }
    }
    
    public func deleteRecordData() {
        let realm = try! Realm()
        let resultRecords = realm.objects(Records.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultRecords)
        }
    }
    
    public func deleteEventData() {
        let realm = try! Realm()
        let resultEvent = realm.objects(EventData.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultEvent)
        }
    }
    
    public func deleteAlertData() {
        let realm = try! Realm()
        let resultAlert = realm.objects(AlertData.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultAlert)
        }
    }
    
    public func deleteLogsData() {
        let realm = try! Realm()
        let resultLog = realm.objects(LogsData.self)
        try! realm.write {
            realm.delete(resultLog)
        }
    }
    
    public func deleteAllData() {
        let realm = try! Realm()
        let resultRecords = realm.objects(Records.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultRecords)
        }
        let resultEvent = realm.objects(EventData.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultEvent)
        }
        let resultAlert = realm.objects(AlertData.self).filter("Check = YES")
        try! realm.write {
            realm.delete(resultAlert)
        }
        let resultLog = realm.objects(LogsData.self)
        try! realm.write {
            realm.delete(resultLog)
        }
    }
    
    public func changeRecordDisplayTime() {
        let realm = try! Realm()
        let refresh = realm.objects(Records.self)
        try! realm.safeWrite {
            print("修改 ADC Record")
            refresh.forEach { (result) in
                print("Index:\(result.ADC2), \(result.DisplayTime) -> \(result.RecordTime.shiftUtc2LocalTZ())")
                result.DisplayTime = result.RecordTime.shiftUtc2LocalTZ()
            }
        }
        let refresh2 = realm.objects(EventData.self)
        try! realm.safeWrite {
            print("修改 Event Record")
            refresh2.forEach { (result2) in
                print("\(result2.DateTime) -> \(result2.DateTime.shiftUtc2LocalTZ())")
                result2.DisplayTime = result2.DateTime.shiftUtc2LocalTZ()
            }
        }
        SDK_Setting.shared.lastTimeZoneNumber = TimeZone.autoupdatingCurrent.secondsFromGMT() / 3600
    }

}

// MARK: - SDK Realm Data Table

public class DB_SensingRecord: Object {
    @objc public dynamic var Timestamp: Int64 = 0
    @objc public dynamic var IndexID: Int = 0
    public var RawData = List<Int>()
    public var CalibrationData = List<Int>()
    @objc public dynamic var Temperature: Int = 0
    @objc public dynamic var Trend: Int = 0
    @objc public dynamic var RSSI: Int = 0
    @objc public dynamic var Battery: Int = 0
    @objc public dynamic var SensorID: String = ""
    @objc public dynamic var UserID: String = ""
    @objc public dynamic var Check: Bool = false // 是否上傳雲端
    @objc public dynamic var isDisplay: Bool = false
}

public class DB_EventTable: Object {
    @objc public dynamic var Index: Int = 0 // 該筆事件的 ID
    @objc public dynamic var TimeStamp: Int64 = 0 // 資料取得的時間 (時間戳)
    @objc public dynamic var EventID: Int = 0 // 事件 ID
    @objc public dynamic var EventValue: Int = 0 // 事件 Value
    public var EventAttribute = List<String>() // 紀錄事件的 Attribute
    @objc public dynamic var Note: String = ""
    @objc public dynamic var Check: Bool = false // 是否上傳雲端
}

public class DB_AlertTable: Object {
    @objc public dynamic var Timestamp: Int64 = 0 // 資料取得的時間 (時間戳)
    @objc public dynamic var AlertID: Int = 0 // 警示事件 ID，對應到 ErrorCode
    @objc public dynamic var AlertValue: Int = 0 // 警示事件 Value，對應到 ErrorValue
    @objc public dynamic var Check: Bool = false // 是否上傳雲端
}

public class DB_PersonalInfo: Object {
    @objc public dynamic var UserID: String = "" // 使用者 ID
    @objc public dynamic var fname: String = "" // 姓名：名
    @objc public dynamic var lname: String = "" // 姓名：姓
    @objc public dynamic var birth: String = "" // 生日
    @objc public dynamic var phone: String = "" // 電話
    @objc public dynamic var IsPhoneBinding: Bool = false // 電話是否綁定
    @objc public dynamic var address: String = "" // 地址
    @objc public dynamic var gender: Int = 0 // 性別
    @objc public dynamic var height: Int = 0 // 身高
    @objc public dynamic var weight: Int = 0 // 體重
    @objc public dynamic var ethnic: Int = 0 // 種族
    @objc public dynamic var drink: Int = 0 // 飲酒程度
    @objc public dynamic var smoke: Bool = false // 是否吸菸
    @objc public dynamic var Check: Bool = false // 是否上傳雲端
    @objc public dynamic var lastRecordCount = "00000000"
    @objc public dynamic var firstRecordCount = "00000000"
    @objc public dynamic var resetCount = 0
}

public class DB_PersonalDynamicInfo: Object {
    @objc public dynamic var UserID: String = "" // 使用者 ID
    @objc public dynamic var Timestamp: Int64 = 0 // 資料取得的時間 (時間戳)
    @objc public dynamic var BodyFatPercentage: Int = 0 // 體脂肪率
    @objc public dynamic var HbA1c: Float = 0.0 // 糖化血色素
    @objc public dynamic var SYS: Int = 0 // 收縮壓
    @objc public dynamic var DIA: Int = 0 // 舒張 = 0
    @objc public dynamic var TC: Int = 0 // 總膽固醇
    @objc public dynamic var HDLC: Int = 0 // 高密度脂蛋白膽固醇
    @objc public dynamic var LDL: Int = 0 // 低密度脂蛋白
    @objc public dynamic var Diabletes: Int = 0 // 有無糖尿病
    @objc public dynamic var CRE: Float = 0.0 // 肌酸酐
}

public class DB_GlucoseCorrectParam: Object {
    @objc public dynamic var ModeID: Int = 0
    @objc public dynamic var RawData2BGBias: Int = 100
    @objc public dynamic var BGBias: Int = 100
    @objc public dynamic var BGLow: Int = 40
    @objc public dynamic var BGHigh: Int = 400
    @objc public dynamic var MapRate: Int = 1
    @objc public dynamic var ThresholdRise: Int = 50
    @objc public dynamic var ThresholdFall: Int = 50
    @objc public dynamic var RiseRate: Int = 100
    @objc public dynamic var FallenRate: Int = 100
}

// MARK: LocalDatabaseManagerDelegate

extension LocalDatabase: LocalDatabaseManagerDelegate {
    
    // MARK: SensingRecord
    
    public func AddRecord(record: SensingRecord) {
        let realm = try! Realm()
        let lastRecords = realm.objects(DB_SensingRecord.self).filter("Timestamp = %lld", record.Timestamp, record.IndexID)
        if lastRecords.count == 0 {
            let records = DB_SensingRecord()
            
            guard let Timestamp = record.Timestamp else {
                print("Realm AddRecord.Timestamp Failed.")
                return
            }
            records.Timestamp = Timestamp
            
            guard let IndexID = record.IndexID else {
                print("Realm AddRecord.IndexID Failed.")
                return
            }
            records.IndexID = IndexID
            
            guard let rawData = record.RawData else {
                print("Realm AddRecord.RawData Failed.")
                return
            }
            for i in 0 ..< rawData.count {
                records.RawData.append(rawData[i])
            }
            
            guard let calibrationData = record.CalibrationData else {
                print("Realm AddRecord.CalibrationData Failed.")
                return
            }
            for i in 0 ..< calibrationData.count {
                records.CalibrationData.append(calibrationData[i])
            }
            
            guard let Temperature = record.Temperature else {
                print("Realm AddRecord.Temperature Failed.")
                return
            }
            records.Temperature = Temperature
            
            guard let Trend = record.Trend else {
                print("Realm AddRecord.Trend Failed.")
                return
            }
            records.Trend = Trend
            
            guard let RSSI = record.RSSI else {
                print("Realm AddRecord.RSSI Failed.")
                return
            }
            records.RSSI = RSSI
            
            guard let Battery = record.Battery else {
                print("Realm AddRecord.Battery Failed.")
                return
            }
            records.Battery = Battery
            
            guard let SensorID = record.SensorID else {
                print("Realm AddRecord.SensorID Failed.")
                return
            }
            records.SensorID = SensorID
            
            guard let UserID = record.UserID else {
                print("Realm AddRecord.UserID Failed.")
                return
            }
            records.UserID = UserID
            
            records.Check = record.Check
            
            records.isDisplay = record.isDisplay
            do {
                try! realm.write {
                    realm.add(records)
                    print("Realm AddRecord Success.")
                }
            } catch {
                print("Realm AddRecord Failed, Error: \(error.localizedDescription)")
            }
            let time = dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
            print("\(time) Realm DB Insert Record Index =  \(record.IndexID)")
        } else {
            let time = dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
            print("\(time) Realm DB Records Duplicate T =  \(time)")
        }
    }
    
    public func UpdateRecord(record: SensingRecord) {
        let realm = try! Realm()
        let time = dateFormatter(format: "MM/dd HH:mm:ss", date: Date())
        let refresh = realm.objects(DB_SensingRecord.self).filter("Timestamp == %lld", record.Timestamp)
        if refresh.count > 0 {
            do {
                try! realm.write {
                    guard let Timestamp = record.Timestamp else {
                        print("Realm UpdateRecord.Timestamp Failed.")
                        return
                    }
                    refresh[0].Timestamp = Timestamp
                    
                    guard let IndexID = record.IndexID else {
                        print("Realm UpdateRecord.IndexID Failed.")
                        return
                    }
                    refresh[0].IndexID = IndexID
                    
                    guard let rawData = record.RawData else {
                        print("Realm UpdateRecord.RawData Failed.")
                        return
                    }
                    refresh[0].RawData.removeAll()
                    for i in 0 ..< rawData.count {
                        refresh[0].RawData.append(rawData[i])
                    }
                    
                    guard let calibrationData = record.CalibrationData else {
                        print("Realm UpdateRecord.CalibrationData Failed.")
                        return
                    }
                    refresh[0].CalibrationData.removeAll()
                    for i in 0 ..< calibrationData.count {
                        refresh[0].CalibrationData.append(calibrationData[i])
                    }
                    
                    guard let Temperature = record.Temperature else {
                        print("Realm UpdateRecord.Temperature Failed.")
                        return
                    }
                    refresh[0].Temperature = Temperature
                    
                    guard let Trend = record.Trend else {
                        print("Realm UpdateRecord.Trend Failed.")
                        return
                    }
                    refresh[0].Trend = Trend
                    
                    guard let RSSI = record.RSSI else {
                        print("Realm UpdateRecord.RSSI Failed.")
                        return
                    }
                    refresh[0].RSSI = RSSI
                    
                    guard let Battery = record.Battery else {
                        print("Realm UpdateRecord.Battery Failed.")
                        return
                    }
                    refresh[0].Battery = Battery
                    
                    guard let SensorID = record.SensorID else {
                        print("Realm UpdateRecord.SensorID Failed.")
                        return
                    }
                    refresh[0].SensorID = SensorID
                    
                    guard let UserID = record.UserID else {
                        print("Realm UpdateRecord.UserID Failed.")
                        return
                    }
                    refresh[0].UserID = UserID
                    
                    refresh[0].Check = record.Check
                    
                    refresh[0].isDisplay = record.isDisplay
                    print("\(time) Realm2 ReWrite Data Index:\(record.IndexID)")
                    print("Realm UpdateRecord Success.")
                }
            } catch {
                print("Realm UpdateRecord Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func GetRecords(userID: String, startTime: Int64, endTime: Int64) -> [SensingRecord] {
        let realm = try! Realm()
        var sensingRecordArray = [SensingRecord]()
        let results = realm.objects(DB_SensingRecord.self).filter("UserID == %s AND Timestamp BETWEEN { %lld, %lld }", userID, startTime, endTime)
        if results.count > 0 {
            for i in 0 ..< results.count {
                let sensingRecord = SensingRecord()
                sensingRecord.Timestamp = results[i].Timestamp
                sensingRecord.IndexID = results[i].IndexID
                sensingRecord.RawData = []
                for j in 0 ..< results[i].RawData.count {
                    sensingRecord.RawData?.append(results[i].RawData[j])
                }
                sensingRecord.CalibrationData = []
                for j in 0 ..< results[i].CalibrationData.count {
                    sensingRecord.CalibrationData?.append(results[i].CalibrationData[j])
                }
                sensingRecord.Temperature = results[i].Temperature
                sensingRecord.Trend = results[i].Trend
                sensingRecord.RSSI = results[i].RSSI
                sensingRecord.Battery = results[i].Battery
                sensingRecord.SensorID = results[i].SensorID
                sensingRecord.UserID = results[i].UserID
                sensingRecord.Check = results[i].Check
                sensingRecord.isDisplay = results[i].isDisplay
                sensingRecordArray.append(sensingRecord)
            }
        }
        return sensingRecordArray
    }

    public func GetRecords(userID: String, Time: Int64) -> SensingRecord {
        let realm = try! Realm()
        let sensingRecord = SensingRecord()
        let results = realm.objects(DB_SensingRecord.self).filter("UserID == %s AND Timestamp == %lld", userID, Time)
        if results.count > 0 {
            sensingRecord.Timestamp = results[0].Timestamp
            sensingRecord.IndexID = results[0].IndexID
            sensingRecord.RawData = []
            for i in 0 ..< results[0].RawData.count {
                sensingRecord.RawData?.append(results[0].RawData[i])
            }
            sensingRecord.CalibrationData = []
            for i in 0 ..< results[0].CalibrationData.count {
                sensingRecord.CalibrationData?.append(results[0].CalibrationData[i])
            }
            sensingRecord.Temperature = results[0].Temperature
            sensingRecord.Trend = results[0].Trend
            sensingRecord.RSSI = results[0].RSSI
            sensingRecord.Battery = results[0].Battery
            sensingRecord.SensorID = results[0].SensorID
            sensingRecord.UserID = results[0].UserID
            sensingRecord.Check = results[0].Check
            sensingRecord.isDisplay = results[0].isDisplay
        }
        return sensingRecord
    }
    
    // MARK: - EventTable
    
    public func AddEvent(event: EventTable) {
        let realm = try! Realm()
        let lastRecords = realm.objects(DB_EventTable.self).filter("TimeStamp = %lld", event.TimeStamp)
        if lastRecords.count == 0 {
            let eventTable = DB_EventTable()
            
            guard let Index = event.Index else {
                print("Realm AddEvent.Index Failed.")
                return
            }
            eventTable.Index = Index
            
            guard let TimeStamp = event.TimeStamp else {
                print("Realm AddEvent.TimeStamp Failed.")
                return
            }
            eventTable.TimeStamp = TimeStamp
            
            guard let EventID = event.EventID else {
                print("Realm AddEvent.EventID Failed.")
                return
            }
            eventTable.EventID = EventID
            
            guard let EventValue = event.EventValue else {
                print("Realm AddEvent.EventValue Failed.")
                return
            }
            eventTable.EventValue = EventValue
            
            guard let eventAttribute = event.EventAttribute else {
                print("Realm AddEvent.EventAttribute Failed.")
                return
            }
            for i in 0 ..< eventAttribute.count {
                eventTable.EventAttribute.append(eventAttribute[i])
            }
            
            guard let Note = event.Note else {
                print("Realm AddEvent.Note Failed.")
                return
            }
            eventTable.Note = Note
            
            eventTable.Check = event.Check
            do {
                try! realm.write {
                    realm.add(eventTable)
                    print("Realm AddEvent Success.")
                }
            } catch {
                print("Realm AddEvent Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func UpdateEvent(event: EventTable) {
        let realm = try! Realm()
        let results = realm.objects(DB_EventTable.self).filter("Index == %d AND TimeStamp == %lld", event.Index, event.TimeStamp)
        if results.count > 0 {
            do {
                try! realm.write {
                    guard let Index = event.Index else {
                        print("Realm UpdateEvent.Index Failed.")
                        return
                    }
                    results[0].Index = Index
                    
                    guard let TimeStamp = event.TimeStamp else {
                        print("Realm UpdateEvent.TimeStamp Failed.")
                        return
                    }
                    results[0].TimeStamp = TimeStamp
                    
                    guard let EventID = event.EventID else {
                        print("Realm UpdateEvent.EventID Failed.")
                        return
                    }
                    results[0].EventID = EventID
                    
                    guard let EventValue = event.EventValue else {
                        print("Realm UpdateEvent.EventValue Failed.")
                        return
                    }
                    results[0].EventValue = EventValue
                    
                    guard let eventAttribute = event.EventAttribute else {
                        print("Realm UpdateEvent.EventAttribute Failed.")
                        return
                    }
                    results[0].EventAttribute.removeAll()
                    for i in 0 ..< eventAttribute.count {
                        results[0].EventAttribute.append(eventAttribute[i])
                    }
                    
                    guard let Note = event.Note else {
                        print("Realm UpdateEvent.Note Failed.")
                        return
                    }
                    results[0].Note = Note
                    
                    results[0].Check = event.Check
                    print("Realm UpdateEvent Success.")
                }
            } catch {
                print("Realm UpdateEvent Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func GetEvents(userID: String, startTime: Int64, endTime: Int64) -> [EventTable] {
        let realm = try! Realm()
        var eventTableArray = [EventTable]()
        let results = realm.objects(DB_EventTable.self).filter("TimeStamp BETWEEN { %lld, %lld }", startTime, endTime)
        if results.count > 0 {
            for i in 0 ..< results.count {
                let eventTable = EventTable()
                eventTable.Index = results[i].Index
                eventTable.TimeStamp = results[i].TimeStamp
                eventTable.EventID = results[i].EventID
                eventTable.EventValue = results[i].EventValue
                eventTable.EventAttribute = []
                for j in 0 ..< results[i].EventAttribute.count {
                    eventTable.EventAttribute?.append(results[i].EventAttribute[j])
                }
                eventTable.Note = results[i].Note
                eventTable.Check = results[i].Check
                eventTableArray.append(eventTable)
            }
        }
        return eventTableArray
    }
    
    // MARK: - AlertTable
    
    public func AddAlert(alert: AlertTable) {
        let realm = try! Realm()
        let lastRecords = realm.objects(DB_AlertTable.self).filter("Timestamp = %lld", alert.Timestamp)
        if (lastRecords.count == 0) {
            let alertTable = DB_AlertTable()
            
            guard let AlertID = alert.AlertID else {
                print("Realm AddAlert.AlertID Failed.")
                return
            }
            alertTable.AlertID = AlertID
            
            guard let AlertValue = alert.AlertValue else {
                print("Realm AddAlert.AlertValue Failed.")
                return
            }
            alertTable.AlertValue = AlertValue
            
            guard let Timestamp = alert.Timestamp else {
                print("Realm AddAlert.Timestamp Failed.")
                return
            }
            alertTable.Timestamp = Timestamp
            
            alertTable.Check = alert.Check
            do {
                try! realm.write {
                    realm.add(alertTable)
                    print("Realm AddAlert Success.")
                }
            } catch {
                print("Realm AddAlert Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func GetAlerts(userID: String, startTime: Int64, endTime: Int64) -> [AlertTable] {
        let realm = try! Realm()
        var alertTableArray = [AlertTable]()
        let results = realm.objects(DB_AlertTable.self).filter("Timestamp BETWEEN { %lld, %lld }", startTime, endTime)
        if results.count > 0 {
            for i in 0 ..< results.count {
                let alertTable = AlertTable()
                alertTable.AlertID = results[i].AlertID
                alertTable.AlertValue = results[i].AlertValue
                alertTable.Timestamp = results[i].Timestamp
                alertTable.Check = results[i].Check
                alertTableArray.append(alertTable)
            }
        }
        return alertTableArray
    }
    
    // MARK: - PersonalInfo
    
    public func AddPersonalInfo(info: PersonalInfo) {
        let realm = try! Realm()
        let lastRecords = realm.objects(DB_PersonalInfo.self).filter("UserID = %s", info.UserID)
        if lastRecords.count == 0 {
            let personalInfo = DB_PersonalInfo()
            
            guard let UserID = info.UserID else {
                print("Realm AddPersonalInfo.UserID Failed.")
                return
            }
            personalInfo.UserID = UserID
            
            guard let FirstName = info.fname else {
                print("Realm AddPersonalInfo.fname Failed.")
                return
            }
            personalInfo.fname = FirstName
            
            guard let LastName = info.lname else {
                print("Realm AddPersonalInfo.lname Failed.")
                return
            }
            personalInfo.lname = LastName
            
            guard let Birthday = info.birth else {
                print("Realm AddPersonalInfo.birth Failed.")
                return
            }
            personalInfo.birth = Birthday
            
            guard let Phone = info.phone else {
                print("Realm AddPersonalInfo.phone Failed.")
                return
            }
            personalInfo.phone = Phone
            
            personalInfo.IsPhoneBinding = info.IsPhoneBinding
            
            guard let Address = info.address else {
                print("Realm AddPersonalInfo.address Failed.")
                return
            }
            personalInfo.address = Address
            
            guard let Gender = info.gender else {
                print("Realm AddPersonalInfo.gender Failed.")
                return
            }
            personalInfo.gender = Gender
            
            guard let Height = info.height else {
                print("Realm AddPersonalInfo.height Failed.")
                return
            }
            personalInfo.height = Height
            
            guard let Weight = info.weight else {
                print("Realm AddPersonalInfo.weight Failed.")
                return
            }
            personalInfo.weight = Weight
            
            guard let Ethnic = info.ethnic else {
                print("Realm AddPersonalInfo.ethnic Failed.")
                return
            }
            personalInfo.ethnic = Ethnic
            
            guard let Drink = info.drink else {
                print("Realm AddPersonalInfo.drink Failed.")
                return
            }
            personalInfo.drink = Drink
            
            personalInfo.smoke = info.smoke
            
            personalInfo.Check = info.Check
            do {
                try! realm.write {
                    realm.add(personalInfo)
                    print("Realm AddPersonalInfo Success.")
                }
            } catch {
                print("Realm AddPersonalInfo Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func UpdatePersonalInfo(info: PersonalInfo) {
        let realm = try! Realm()
        let results = realm.objects(DB_PersonalInfo.self).filter("UserID == %s", info.UserID)
        if results.count > 0 {
            do {
                try! realm.write {
                    guard let UserID = info.UserID else {
                        print("Realm UpdatePersonalInfo.UserID Failed.")
                        return
                    }
                    results[0].UserID = UserID
                    
                    guard let FirstName = info.fname else {
                        print("Realm UpdatePersonalInfo.fname Failed.")
                        return
                    }
                    results[0].fname = FirstName
                    
                    guard let LastName = info.lname else {
                        print("Realm UpdatePersonalInfo.lname Failed.")
                        return
                    }
                    results[0].lname = LastName
                    
                    guard let Birthday = info.birth else {
                        print("Realm UpdatePersonalInfo.birth Failed.")
                        return
                    }
                    results[0].birth = Birthday
                    
                    guard let Phone = info.phone else {
                        print("Realm UpdatePersonalInfo.phone Failed.")
                        return
                    }
                    results[0].phone = Phone
                    
                    results[0].IsPhoneBinding = info.IsPhoneBinding
                    
                    guard let Address = info.address else {
                        print("Realm UpdatePersonalInfo.address Failed.")
                        return
                    }
                    results[0].address = Address
                    
                    guard let Gender = info.gender else {
                        print("Realm UpdatePersonalInfo.gender Failed.")
                        return
                    }
                    results[0].gender = Gender
                    
                    guard let Height = info.height else {
                        print("Realm UpdatePersonalInfo.height Failed.")
                        return
                    }
                    results[0].height = Height
                    
                    guard let Weight = info.weight else {
                        print("Realm UpdatePersonalInfo.weight Failed.")
                        return
                    }
                    results[0].weight = Weight
                    
                    guard let Ethnic = info.ethnic else {
                        print("Realm UpdatePersonalInfo.ethnic Failed.")
                        return
                    }
                    results[0].ethnic = Ethnic
                    
                    guard let Drink = info.drink else {
                        print("Realm UpdatePersonalInfo.drink Failed.")
                        return
                    }
                    results[0].drink = Drink
                    
                    results[0].smoke = info.smoke
                    
                    results[0].Check = info.Check
                    print("Realm UpdatePersonalInfo Success.")
                }
            } catch {
                print("Realm UpdatePersonalInfo Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func GetPersonalInfo(userID: String) -> PersonalInfo {
        let realm = try! Realm()
        let personalInfo = PersonalInfo()
        let results = realm.objects(DB_PersonalInfo.self).filter("UserID == %s", userID)
        if results.count > 0 {
            personalInfo.UserID = results[0].UserID
            personalInfo.fname = results[0].fname
            personalInfo.lname = results[0].lname
            personalInfo.birth = results[0].birth
            personalInfo.phone = results[0].phone
            personalInfo.IsPhoneBinding = results[0].IsPhoneBinding
            personalInfo.address = results[0].address
            personalInfo.gender = results[0].gender
            personalInfo.height = results[0].height
            personalInfo.weight = results[0].weight
            personalInfo.ethnic = results[0].ethnic
            personalInfo.drink = results[0].drink
            personalInfo.smoke = results[0].smoke
            personalInfo.Check = results[0].Check
        }
        return personalInfo
    }
    
    // MARK: - PersonalDynamicInfo
    
    public func AddPersonDynamicInfo(info: PersonalDynamicInfo) {
        let realm = try! Realm()
        let lastRecords = realm.objects(DB_PersonalDynamicInfo.self).filter("UserID = %s AND TimeStamp = %lld", info.UserID, info.Timestamp)
        if lastRecords.count == 0 {
            let personalDynamicInfo = DB_PersonalDynamicInfo()
            
            guard let UserID = info.UserID else {
                print("Realm AddPersonDynamicInfo.UserID Failed.")
                return
            }
            personalDynamicInfo.UserID = UserID
            
            guard let Timestamp = info.Timestamp else {
                print("Realm AddPersonDynamicInfo.Timestamp Failed.")
                return
            }
            personalDynamicInfo.Timestamp = Timestamp
            
            guard let BodyFatPercentage = info.BodyFatPercentage else {
                print("Realm AddPersonDynamicInfo.BodyFatPercentage Failed.")
                return
            }
            personalDynamicInfo.BodyFatPercentage = BodyFatPercentage
            
            guard let HbA1c = info.HbA1c else {
                print("Realm AddPersonDynamicInfo.HbA1c Failed.")
                return
            }
            personalDynamicInfo.HbA1c = HbA1c
            
            guard let SYS = info.SYS else {
                print("Realm AddPersonDynamicInfo.SYS Failed.")
                return
            }
            personalDynamicInfo.SYS = SYS
            
            guard let DIA = info.DIA else {
                print("Realm AddPersonDynamicInfo.DIA Failed.")
                return
            }
            personalDynamicInfo.DIA = DIA
            
            guard let TC = info.TC else {
                print("Realm AddPersonDynamicInfo.TC Failed.")
                return
            }
            personalDynamicInfo.TC = TC
            
            guard let HDLC = info.HDLC else {
                print("Realm AddPersonDynamicInfo.HDLC Failed.")
                return
            }
            personalDynamicInfo.HDLC = HDLC
            
            guard let LDL = info.LDL else {
                print("Realm AddPersonDynamicInfo.LDL Failed.")
                return
            }
            personalDynamicInfo.LDL = LDL
            
            guard let Diabletes = info.Diabletes else {
                print("Realm AddPersonDynamicInfo.Diabletes Failed.")
                return
            }
            personalDynamicInfo.Diabletes = Diabletes
            
            guard let CRE = info.CRE else {
                print("Realm AddPersonDynamicInfo.CRE Failed.")
                return
            }
            personalDynamicInfo.CRE = CRE
            do {
                try! realm.write {
                    realm.add(personalDynamicInfo)
                    print("Realm AddPersonDynamicInfo Success.")
                }
            } catch {
                print("Realm AddPersonDynamicInfo Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func UpdatePersonDynamicInfo(info: PersonalDynamicInfo) {
        let realm = try! Realm()
        let results = realm.objects(DB_PersonalDynamicInfo.self).filter("UserID == %s AND TimeStamp == %lld", info.UserID, info.Timestamp)
        if results.count > 0 {
            do {
                try! realm.write {
                    guard let UserID = info.UserID else {
                        print("Realm UpdatePersonDynamicInfo.UserID Failed.")
                        return
                    }
                    results[0].UserID = UserID
                    
                    guard let Timestamp = info.Timestamp else {
                        print("Realm UpdatePersonDynamicInfo.Timestamp Failed.")
                        return
                    }
                    results[0].Timestamp = Timestamp
                    
                    guard let BodyFatPercentage = info.BodyFatPercentage else {
                        print("Realm UpdatePersonDynamicInfo.BodyFatPercentage Failed.")
                        return
                    }
                    results[0].BodyFatPercentage = BodyFatPercentage
                    
                    guard let HbA1c = info.HbA1c else {
                        print("Realm UpdatePersonDynamicInfo.HbA1c Failed.")
                        return
                    }
                    results[0].HbA1c = HbA1c
                    
                    guard let SYS = info.SYS else {
                        print("Realm UpdatePersonDynamicInfo.SYS Failed.")
                        return
                    }
                    results[0].SYS = SYS
                    
                    guard let DIA = info.DIA else {
                        print("Realm UpdatePersonDynamicInfo.DIA Failed.")
                        return
                    }
                    results[0].DIA = DIA
                    
                    guard let TC = info.TC else {
                        print("Realm UpdatePersonDynamicInfo.TC Failed.")
                        return
                    }
                    results[0].TC = TC
                    
                    guard let HDLC = info.HDLC else {
                        print("Realm UpdatePersonDynamicInfo.HDLC Failed.")
                        return
                    }
                    results[0].HDLC = HDLC
                    
                    guard let LDL = info.LDL else {
                        print("Realm UpdatePersonDynamicInfo.LDL Failed.")
                        return
                    }
                    results[0].LDL = LDL
                    
                    guard let Diabletes = info.Diabletes else {
                        print("Realm UpdatePersonDynamicInfo.Diabletes Failed.")
                        return
                    }
                    results[0].Diabletes = Diabletes
                    
                    guard let CRE = info.CRE else {
                        print("Realm UpdatePersonDynamicInfo.CRE Failed.")
                        return
                    }
                    results[0].CRE = CRE
                    print("Realm UpdatePersonDynamicInfo Success.")
                }
            } catch {
                print("Realm UpdatePersonDynamicInfo Failed, Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func GetPersonDynamicInfo(userID: String) -> [PersonalDynamicInfo] {
        let realm = try! Realm()
        var personalDynamicInfoArray = [PersonalDynamicInfo]()
        let results = realm.objects(DB_PersonalDynamicInfo.self).filter("UserID == %s", userID)
        if results.count > 0 {
            for i in 0 ..< results.count {
                let personalDynamicInfo = PersonalDynamicInfo()
                personalDynamicInfo.UserID = results[i].UserID
                personalDynamicInfo.Timestamp = results[i].Timestamp
                personalDynamicInfo.BodyFatPercentage = results[i].BodyFatPercentage
                personalDynamicInfo.HbA1c = results[i].HbA1c
                personalDynamicInfo.SYS = results[i].SYS
                personalDynamicInfo.DIA = results[i].DIA
                personalDynamicInfo.TC = results[i].TC
                personalDynamicInfo.HDLC = results[i].HDLC
                personalDynamicInfo.LDL = results[i].LDL
                personalDynamicInfo.Diabletes = results[i].Diabletes
                personalDynamicInfo.CRE = results[i].CRE
                personalDynamicInfoArray.append(personalDynamicInfo)
            }
        }
        return personalDynamicInfoArray
    }
    
    // MARK: - GlucoseCorrectParam
    
    public func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam) {
        let realm = try! Realm()
        let results = realm.objects(DB_GlucoseCorrectParam.self)
        if results.count > 0 {
            do {
                try! realm.write {
                    results[0].ModeID = event.ModeID ?? 0
                    results[0].RawData2BGBias = event.RawData2BGBias ?? 100
                    results[0].BGBias = event.BGBias ?? 100
                    results[0].BGLow = event.BGLow ?? 40
                    results[0].BGHigh = event.BGHigh ?? 400
                    results[0].MapRate = event.MapRate ?? 1
                    results[0].ThresholdRise = event.ThresholdRise ?? 50
                    results[0].ThresholdFall = event.ThresholdFall ?? 50
                    results[0].RiseRate = event.RiseRate ?? 100
                    results[0].FallenRate = event.FallenRate ?? 100
                    print("Realm UpdateGlucoseCorrectParam Success.")
                }
                DataCorrectionAlgo.share.UpdateAlgoParam(param: event)
            } catch {
                print("Realm UpdateGlucoseCorrectParam Failed, Error: \(error.localizedDescription)")
            }
        } else {
            if (SDK_Setting.shared.isFirstLogin) { print("使用者首次登入") }
            let param = DB_GlucoseCorrectParam()
            param.ModeID = event.ModeID ?? 0
            param.RawData2BGBias = event.RawData2BGBias ?? 100
            param.BGBias = event.BGBias ?? 100
            param.BGLow = event.BGLow ?? 40
            param.BGHigh = event.BGHigh ?? 400
            param.MapRate = event.MapRate ?? 1
            param.ThresholdRise = event.ThresholdRise ?? 50
            param.ThresholdFall = event.ThresholdFall ?? 50
            param.RiseRate = event.RiseRate ?? 100
            param.FallenRate = event.FallenRate ?? 100
            do {
                try! realm.write {
                    realm.add(param)
                    print("Realm AddGlucoseCorrectParam Success.")
                }
                DataCorrectionAlgo.share.UpdateAlgoParam(param: event)
            } catch {
                print("Realm AddGlucoseCorrectParam Failed, Error: \(error.localizedDescription)")
            }
        }
        print("File URL:\(realm.configuration.fileURL!)")
    }
    
    public func GetGlucoseCorrectParam(userID: String) -> GlucoseCorrectParam {
        let realm = try! Realm()
        let glucoseCorrectParam = GlucoseCorrectParam()
        let results = realm.objects(DB_GlucoseCorrectParam.self)
        if results.count > 0 {
            glucoseCorrectParam.ModeID = results[0].ModeID
            glucoseCorrectParam.RawData2BGBias = results[0].RawData2BGBias
            glucoseCorrectParam.BGBias = results[0].BGBias
            glucoseCorrectParam.BGLow = results[0].BGLow
            glucoseCorrectParam.BGHigh = results[0].BGHigh
            glucoseCorrectParam.MapRate = results[0].MapRate
            glucoseCorrectParam.ThresholdRise = results[0].ThresholdRise
            glucoseCorrectParam.ThresholdFall = results[0].ThresholdFall
            glucoseCorrectParam.RiseRate = results[0].RiseRate
            glucoseCorrectParam.FallenRate = results[0].FallenRate
        }
        return glucoseCorrectParam
    }
    
}

extension LocalDatabase {
    
    func dateFormatter(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let str = formatter.string(from: date)
        return str
    }
    
}
