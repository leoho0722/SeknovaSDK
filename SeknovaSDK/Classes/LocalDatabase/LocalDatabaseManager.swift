//
//  LocalDatabaseManager.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/24.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class LocalDatabaseManager: NSObject {

}

// MARK: - 這邊是給專案內用的

@objc public protocol LocalDatabaseDelegate: NSObjectProtocol {
    // MARK: 血糖紀錄
    
    /// 新增血糖紀錄
    /// - Parameters:
    ///   - Count: Int
    ///   - RecordTime: String
    ///   - DisplayTime: String
    ///   - Temperature: Int
    ///   - ADC1: Int
    ///   - ADC2: Int
    ///   - RawData: Int
    ///   - RSSI: Int
    ///   - Battery: Int
    ///   - Check: Bool，該筆血糖資料是否上傳雲端
    ///   - Calibrated: Bool，該筆血糖資料是否經過校正
    @objc optional func AddRecord(Count: Int, RecordTime: String, DisplayTime: String, Temperature: Int,
                                  ADC1: Int, ADC2: Int, RawData: Int, RSSI: Int, Battery: Int, Check: Bool, Calibrated: Bool)
    
    /// 刪除已上傳雲端的血糖紀錄資料
    @objc optional func deleteRecordData()
    
    // MARK: - 血糖校正、生活作息
    
    /// 新增血糖校正、生活作息
    ///  - Parameters:
    ///    - Id: Int
    ///    - DateTime: String，UTC+0 的時間
    ///    - DisplayTime: String，當前時區的時間
    ///    - EventID: Int
    ///    - EventValue: Int
    ///    - EventAttribute: [String]，Realm 只支援 List，所以要在手動轉換
    @objc optional func AddEvent(Id: Int, DateTime: String, DisplayTime: String, EventID: Int,
                                 EventValue: Int, EventAttribute: [String], Note: String, Check: Bool)
    
    /// 刪除已上傳雲端的血糖校正、生活作息資料
    @objc optional func deleteEventData()
    
    // MARK: - 警示通知
    
    /// 新增警示通知
    /// - Parameters:
    ///   - ErrorCode: Int
    ///   - ErrorValue: Int
    ///   - RecordTime: String
    ///   - Check: Bool，該筆資料是否上傳雲端
    @objc optional func AddAlert(ErrorCode: Int, ErrorValue: Int, RecordTime: String, Check: Bool)
    
    /// 刪除已上傳雲端的警示通知資料
    @objc optional func deleteAlertData()
    
    // MARK: - 日誌記錄
    
    /// 新增日誌記錄
    /// - Parameters:
    ///   - Log: String
    ///   - time: String
    @objc optional func addLogsData(Log: String, time: String)
    
    /// 刪除日誌記錄資料
    @objc optional func deleteLogsData()
    
    // MARK: - 身體資訊蒐集、個人資訊
    
    /// 新增身體資訊蒐集、個人資訊
    /// - Parameters:
    ///   - UserID: String
    ///   - FirstName: String
    ///   - LastName: String
    ///   - Birthday: String
    ///   - Email: String
    ///   - Phone: String
    ///   - Address: String
    ///   - Gender: Int，性別
    ///   - Height: Int
    ///   - Weight: Int
    ///   - Race: Int，種族
    ///   - Liquor: Int，飲酒程度
    ///   - Smoke: Bool，是否抽煙
    ///   - Phone_Verified: Int，該用戶是否經過手機綁定驗證
    ///   - Check: Bool，該筆資料是否上傳雲端
    @objc optional func AddPersonalInfo(UserID: String, FirstName: String, LastName: String, Birthday: String, Email: String,
                                        Phone: String, Address: String, Gender: Int, Height: Int, Weight: Int,
                                        Race: Int, Liquor: Int, Smoke: Bool, Phone_Verified: Int, Check: Bool)
    
    // MARK: - 血糖校正本地算法參數
    
    /// 新增／更新血糖校正本地算法參數
    /// - Parameters:
    ///   - ModeID: Int
    ///   - RawData2BGBias: Int
    ///   - BGBias: Int
    ///   - BGLow: Int
    ///   - BGHigh: Int
    ///   - MapRate: String
    ///   - ThresholdRise: String
    ///   - ThresholdFall: String
    ///   - RiseRate: String
    ///   - FallenRate: String
    ///   - showAlert: Bool，是否要顯示 `更新成功` 的 Alert
    ///   - vc: UIViewController，要顯示 `更新成功` 的 ViewController
    @objc optional func UpdateGlucoseCorrectParam(ModeID: Int, RawData2BGBias: Int, BGBias: Int, BGLow: Int,
                                                  BGHigh: Int, MapRate: String, ThresholdRise: String,
                                                  ThresholdFall: String, RiseRate: String, FallenRate: String,
                                                  finish: (() -> Void)?)
    
    // MARK: - 儲存血糖紀錄次數
    
    /// 儲存血糖紀錄次數
    @objc optional func saveRecordCountData()
    
    // MARK: - 刪除全部資料
    
    /// 刪除全部資料
    @objc optional func deleteAllData()
    
    // MARK: - 更換紀錄顯示時間
    
    /// 更換紀錄顯示時間
    @objc optional func changeRecordDisplayTime()
}

// MARK: - 下面是給外面開發者用的

@objc public protocol LocalDatabaseManagerDelegate: NSObjectProtocol {
    // MARK: SensingRecord
    
    /// 儲存 SensingRecord 到資料庫
    /// - Parameters:
    ///   - record: SensingRecord，須存入本地資料庫的 SensingRecord 資料結構
    @objc optional func AddRecord(record: SensingRecord)
    
    /// 更新 SensingRecord 到資料庫
    /// - Parameters:
    ///   - record: SensingRecord，須存入本地資料庫的 SensingRecord 資料結構
    @objc optional func UpdateRecord(record: SensingRecord)
    
    /// 從 SensingRecord 資料庫取得資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 SensingRecord 資料，[SensingRecord]
    @objc optional func GetRecords(userID: String, startTime: Int64, endTime: Int64) -> [SensingRecord]
    
    /// 從 SensingRecord 資料庫取得資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - Time: Int64，查詢的時間
    /// - Returns: 從資料庫取出的 SensingRecord 資料，SensingRecord
    @objc optional func GetRecords(userID: String, Time: Int64) -> SensingRecord
    
    // MARK: - EventTable
    
    /// 儲存 EventTable 到資料庫
    /// - Parameters:
    ///   - event: EventTable，須存入本地資料庫的 EventTable
    @objc optional func AddEvent(event: EventTable)
    
    /// 更新 EventTable 到資料庫
    /// - Parameters:
    ///   - event: EventTable，須存入本地資料庫的 EventTable
    @objc optional func UpdateEvent(event: EventTable)
    
    /// 查詢 Event 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 EventTable 資料，[EventTable]
    @objc optional func GetEvents(userID: String, startTime: Int64, endTime: Int64) -> [EventTable]
    
    // MARK: - AlertTable
    
    /// 儲存 AlertTable 到資料庫
    /// - Parameters:
    ///   - alert: AlertTable，須存入本地資料庫的 AlertTable
    @objc optional func AddAlert(alert: AlertTable)
    
    /// 查詢 AlertTable 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 AlertTable 資料，[AlertTable]
    @objc optional func GetAlerts(userID: String, startTime: Int64, endTime: Int64) -> [AlertTable]
    
    // MARK: - PersonalInfo
    
    /// 儲存 PersonalInfo 到資料庫
    /// - Parameters:
    ///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
    @objc optional func AddPersonalInfo(info: PersonalInfo)
    
    /// 更新 PersonalInfo 到資料庫
    /// - Parameters:
    ///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
    @objc optional func UpdatePersonalInfo(info: PersonalInfo)
    
    /// 查詢 PersonalInfo 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 PersonalInfo 資料，PersonalInfo
    @objc optional func GetPersonalInfo(userID: String) -> PersonalInfo
    
    // MARK: - PersonalDynamicInfo
    
    /// 儲存 PersonalDynamicInfo 到資料庫
    /// - Parameters:
    ///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
    @objc optional func AddPersonDynamicInfo(info: PersonalDynamicInfo)
    
    /// 更新 PersonalDynamicInfo 到資料庫
    /// - Parameters:
    ///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
    @objc optional func UpdatePersonDynamicInfo(info: PersonalDynamicInfo)
    
    /// 查詢 PersonalDynamicInfo 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 PersonalDynamicInfo 陣列，[PersonalDynamicInfo]
    @objc optional func GetPersonDynamicInfo(userID: String) -> [PersonalDynamicInfo]
    
    // MARK: - GlucoseCorrectParam
    
    /// 更新 `血糖校正算法參數` 到資料庫
    /// - Parameters:
    ///   - event: GlucoseCorrectParam，須存入本地資料庫的 GlucoseCorrectParam
    @objc optional func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
    
    /// 查詢 GlucoseCorrectParam 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 GlucoseCorrectParam 資料
    @objc optional func GetGlucoseCorrectParam(userID: String) -> GlucoseCorrectParam
}
