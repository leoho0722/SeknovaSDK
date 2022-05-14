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

extension LocalDatabase {
    
    func dateFormatter(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let str = formatter.string(from: date)
        return str
    }
    
}
