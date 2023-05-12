# Seknova iOS SDK 使用文件

## 簡介

Seknova iOS SDK 上架於第三方套件庫 CocoaPods，採用 Xcode 13.1 + Swift 5 進行開發

SDK 連結：[CocoaPods](https://cocoapods.org/pods/SeknovaSDK) &emsp; [GitHub](https://github.com/leoho0722/SeknovaSDK)

Seknova iOS SDK 主要分為五大類別

- 基本儲存類別 (資料儲存結構)
- 藍牙類別
  - 主要處理藍牙 Interface 的部份
- 帳號管理類別
  - 主要處理跟 AWS Cognito 相關的部份
- 本地資料庫類別
  - 主要處理存取本地資料庫以及寫入資料儲存的部份
- 雲端 API 類別
  - 主要處理 Web Restful API 的 JSON 格式轉換與解析，加速串接用

![SDK 架構圖](https://i.imgur.com/DMwhHsS.png)

---

## 基本儲存類別

### Class TransmitterInfo

#### Description

- 記錄發射器的資訊

#### Parameters

```swift
public var TransmitterID: String?        // 發射器 ID

public var UserID: String?               // 使用者 ID

public var TransmitterTime: Int?         // 發射器啟用時間

public var TransmitterTotalLife: Int?    // 發射器壽命

public var BatteryLevel: Int?            // 電池電量

public var FWVersion: String?            // 韌體版本

public var MacAddr: String?              // MAC 位址

public var ResetCount: Int?              // 重設次數

public var ChargeCount: Int?             // 充電次數

public var TransmitterState: Int?        // 發射器狀態

public var SensorState: Int?             // 感測器狀態

public var SensorType: Int?              // 感測器種類

public var SensorLocation: Int?          // 感測器位置

public var Remain_warmUp_time: Int?      // 預計剩餘暖機時間

public var Remain_calibration_time: Int? // 預計剩餘校正時間
```

#### Function

```swift
/// 取得發射器的已使用時間
public func GetUsedTime() -> Int
```

### Class SensorInfo

#### Description

- 記錄感測器對應的資訊以及使用者

#### Parameters

```swift
public var SensorID: String?      // 感測器 ID

public var TransmitterID: String? // 發射器 ID

public var UserID: String?        // 使用者 ID

public var SensorStartTime: Int?  // 感測器啟用時間

public var SensorTotalLife: Int?  // 感測器總壽命
```

#### Function

```swift
/// 取得感測器的已使用時間
public func GetUsedTime() -> Int
```

### Class SensingRecord

#### Description

- 記錄感測器所取得的數據以及感測器資訊的資料結構

#### Parameters

```swift
public var Timestamp: Int64?       // 該筆記錄的時間戳

public var IndexID: Int?           // 該筆記錄的 Index

public var RawData: [Int]?         // 該筆記錄的原始資料

public var CalibrationData: [Int]? // 該筆記錄的校正後的血糖資料

public var Temperature: Int?       // 該筆記錄的感測器溫度

public var Trend: Int?             // 該筆記錄的斜率

public var RSSI: Int?              // 該筆記錄的感測器 RSSI 訊號

public var Battery: Int?           // 該筆記錄的感測器電量

public var SensorID: String?       // 該筆記錄的感測器 ID

public var UserID: String?         // 該筆記錄的使用者 ID

public var Check: Bool = false     // 是否上傳雲端

public var isDisplay: Bool = false // 該筆記錄是否顯示給使用者
```

### Class EventTable

#### Description

- 記錄使用者生活作息與血糖相關事件

#### Parameters

```swift
public var Index: Int?               // 該筆事件的 Index

public var TimeStamp: Int64?         // 該筆事件的時間戳

public var EventID: Int?             // 該筆事件的事件 ID

public var EventValue: Int?          // 該筆事件的事件 Value

public var EventAttribute: [String]? // 該筆事件的 Attribute

public var Note: String?             // 該筆事件的註記

public var Check: Bool = false       // 該筆事件是否上傳雲端
```

### Class AlertTable

#### Description

- 記錄警示事件

#### Parameters

```swift
public var Timestamp: Int64?   // 該筆警示事件的時間戳

public var AlertID: Int?       // 該筆警示事件的 ID

public var AlertValue: Int?    // 該筆警示事件的 Value

public var Check: Bool = false // 該筆警示事件是否上傳雲端
```

### Class PersonalInfo

#### Description

- 記錄使用者個人資料

#### Parameters

```swift
public var UserID: String?              // 使用者 ID

public var fname: String?               // 使用者姓名：名

public var lname: String?               // 使用者姓名：姓

public var birth: String?               // 使用者生日

public var phone: String?               // 使用者電話

public var IsPhoneBinding: Bool = false // 使用者電話是否綁定

public var address: String?             // 使用者地址

public var gender: Int?                 // 使用者性別

public var height: Int?                 // 使用者身高

public var weight: Int?                 // 使用者體重

public var ethnic: Int?                 // 使用者種族

public var drink: Int?                  // 使用者飲酒程度

public var smoke: Bool = false          // 使用者是否吸菸

public var Check: Bool = false          // 是否上傳雲端
```

#### Function

```swift
/// 驗證 PersonalInfo 內的各參數是否為 nil，以及格式是否正確
public func Validate() -> Bool
```

### Class PersonalDynamicInfo

#### Description

- 記錄使用者個人時效性的生理資料

#### Parameters

```swift
public var UserID: String?         // 使用者 ID

public var Timestamp: Int64?       // 資料取得的時間 (時間戳)

public var BodyFatPercentage: Int? // 體脂肪率

public var HbA1c: Float?           // 糖化血色素

public var SYS: Int?               // 收縮壓

public var DIA: Int?               // 舒張壓

public var TC: Int?                // 總膽固醇

public var HDLC: Int?              // 高密度脂蛋白膽固醇

public var LDL: Int?               // 低密度脂蛋白

public var Diabletes: Int?         // 有無糖尿病

public var CRE: Float?             // 肌酸酐
```

### Class GlucoseCorrectParam

#### Description

- 血糖校正算法參數

#### Parameters

```swift
public var ModeID: Int?

public var RawData2BGBias: Int?

public var BGBias: Int?

public var BGLow: Int?

public var BGHigh: Int?

public var MapRate: Int?

public var ThresholdRise: Int?

public var ThresholdFall: Int?

public var RiseRate: Int?

public var FallenRate: Int?
```

### Class StartTimeConfigure

#### Description

- 紀錄設定使用時間的資料結構

#### Parameters

```swift
public var year: UInt16?       // 年

public var month: UInt8?       // 月

public var day: UInt8?         // 日

public var hours: UInt8?       // 小時

public var minutes: UInt8?     // 分鐘

public var seconds: UInt8?     // 秒

public var timeZone: Int8?     // 時區 GMT

public var daySaveTime: UInt8? // 日光節約時間
```

---

## 藍牙類別

### Class SDK_BluetoothService

#### Single Pattern

```swift
public static let shareInstance = SDK_BluetoothService()
```

#### Event CallBack Parameters

| EventID | Value                   | Note                                     |
|---------|-------------------------|------------------------------------------|
| 1       | 0：成功 1：無找到裝置資訊 | 已讀取 TransmitterInfo 資料              |
| 2       | 0：無用                  | 已讀取當前 SensingRecord 資料            |
| 3       | N：資料筆數              | 已讀取 (回補) 過去的 SensingRecord       |
| 4       | 0：成功 1：失敗           | 設定 SensorID 完成                       |
| 5       | 0：成功 1：失敗           | 設定血糖校正完成                         |
| 6       | 0：成功 1：失敗           | 裝置狀態通知 (Sensor Status Notify Code) |

Sensor Status Notify Code
| Code | Senosr Status                    |
|------|----------------------------------|
| 0    | SESSION_STOPPED                  |
| 1    | DEVICE_BATTERY_LOW               |
| 2    | SENSOR_TYPE_INCORRECT_FOR_DEVICE |
| 3    | SENSOR_MALFUNCTION               |
| 4    | DEVICE_SPECIFIC_ALERT            |
| 5    | GENERAL_DEVICE_FAULT             |
| 6    | WARM-UP TIME                     |
| 7    | INTERNAL_CALIBRATION             |

#### Protocol

```swift
public var delegate: BluetoothDelegateListener?

@objc public protocol BluetoothDelegateListener: NSObjectProtocol {
    
    /// BLE 發現 Services 的處理函數。
    func HandlePeripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
     
    /// BLE 發現 Characteristics 的處理函數。
    func HandlePeripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    
    /// BLE Characteristics 值 Read/notify 的處理函數。
    func HandlePeripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    
    /// BLE Characteristics 值 write 的處理函數。
    func HandlePeripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?)
    
    /// 事件回傳
    func EventCallback(eventID: Int, value: Int)
    
}
```

#### Function

```swift
/// 說明：讀取藍牙資訊取得 TransmitterInfo，收到 EventCallback 時呼叫
public func getTransmitterInfo() -> TransmitterInfo?

/// 說明：讀取藍牙資訊取得最新一筆 SensingRecord，收到 EventCallback 時呼叫
public func getSensingRecordInfo() -> SensingRecord?

/// 說明：讀取藍牙資訊取得過去的 SensingRecord，收到 EventCallback 時呼叫
public func getSyncRecords() -> [SensingRecord]?

/// 說明：設定需要進行資料回補的資料序號
public func setSyncRecordIndex(idxArray: [Int])

/// 說明：設定 SensorID 到傳輸器
/// 實際寫入的時間需等待到藍牙連線時啟動，並透過 Callback 通知是否完成
public func setSensorID(sensorID: String)

/// 說明: 設定 Sensor 啟用時間
/// 實際寫入的時間需等待到藍牙連線時啟動，並透過 Callback 通知是否完成
/// - Parameters:
///   - currentTime: Bool 是否使用連線到裝置時的當前時間，true 的話第二個參數設定為 Null，false 的話用第二個參數的時間設定。
///   - config: time
public func setSensorStartTime(currentTime: Bool, config: Date?)

/// 說明: 設定校正血糖到傳輸器
/// 實際寫入的時間需等待到藍牙連線時啟動，並透過 Callback 通知是否完成
/// - Parameters:
///   - calibration: 寫入的血糖值 (mg/dL)
public func setCalibration(calibration: Int)
```

---

## 帳號管理類別

### Class AccountManager

#### Description

- 存取 AWS Cognito 的 Interface 類別

#### Function

```swift
/// 使用者登入 (Email 一般登入)
/// - Parameters:
///   - username: String，使用者帳號
///   - password: String，使用者設定的密碼
///   - finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void
///     - SignInResult?，使用者登入的結果
///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
///     - Error?，AWSMobileClientError
///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserSignIn(username: String, password: String, finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void)

/// 使用者登入 (第三方登入，Sign in with Apple、Facebook、Google)
/// - Parameters:
///   - hostedUIOption: HostedUIOptions，第三方登入提供商
///   - navigationController: UINavigationController，用來呈現第三方登入頁面的
///   - finish: @escaping(UserState?, String?, Error?, UInt8)
///     - UserState?，AWS Cognito 使用者登入狀態
///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
///     - Error?，AWSMobileClientError
///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ShowSignIn(hostedUIOption: HostedUIOptions, navigationController: UINavigationController, finish: @escaping(UserState?, String?, Error?, UInt8) -> Void)

/// 使用者登出
public func UserSignOut()

/// 使用者註冊
/// - Parameters:
///    - username: String，使用者帳號
///    - password: String，使用者設定的密碼
///    - locale: String，使用者設定的國籍
///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
///      - SignUpResult?，使用者註冊的結果
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserSignUp(username: String, password: String, locale: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void)

/// 使用者驗證碼輸入 (輸入手機綁定驗證碼)
/// - Parameters:
///   - username: String，使用者帳號
///   - code: String，6 碼驗證碼
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ConfirmVerifyUser(username: String, code: String, finish: @escaping(Error?, UInt8) -> Void)

/// 使用者驗證 (重送驗證信)
/// - Parameters:
///    - username: String，使用者帳號
///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
///      - SignUpResult?，使用者重送驗證信的結果
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ResendSignUpVerifyCode(username: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void)

/// 使用者忘記密碼觸發驗證碼發送
/// - Parameters:
///   - username: String，使用者帳號
///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
///      - ForgotPasswordResult?，忘記密碼的資料
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ForgotPassword(username: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void)

/// 使用者忘記密碼重新設定
/// - Parameters:
///   - username: String，使用者帳號
///   - newPassword: String，使用者新設定的密碼
///   - confirmCode: String，確認驗證碼
///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
///      - ForgotPasswordResult?，忘記密碼的資料
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ComfirmForgotPassword(username: String, newPassword: String, confirmCode: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void)

/// 使用者修改密碼
/// - Parameters:
///   - username: String，使用者帳號
///   - currentPassword: String，使用者目前的密碼
///   - newPassword: String，使用者新設定的密碼
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserChangePassword(username: String, currentPassword: String, newPassword: String, finish: @escaping(Error?, UInt8) -> Void)

/// 取得使用者紀錄之屬性
/// - Parameters:
///    - finish: @escaping([String: String]?, Error?) -> Void
///      - [String: String]?，使用者在 AWS 上的屬性
///      - Error?，AWSMobileClientError
public func GetAttribute(finish: @escaping([String: String]?, Error?) -> Void)

/// 更新使用者屬性
/// - Parameters:
///   - input: [String: String]
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UpdateAttribute(input: [String: String], finish: @escaping(Error?, UInt8) -> Void)
```

---

## 本地資料庫類別

#### Description

Seknova iOS SDK 內建本地資料庫為 RealmSwift 10.20.0

Seknova iOS SDK 為方便外部開發者使用，採用 Protocol 方式宣告本地資料庫類別

並在 SDK 內實作 Protocol 內的各個 Function 於 class LocalDatabase

因此外部開發者您可以自由選擇是否採用 Seknova iOS SDK 內建本地資料庫

亦或是自行實作 Protocol 內的 Function 於您的專案項目中

### Class LocalDatabase

#### Single Pattern

```swift
public static let shared = LocalDatabase()
```

#### Protocol

```swift
@objc public protocol LocalDatabaseManagerDelegate: NSObjectProtocol {
    
    /// 新增 SensingRecord 資料到資料庫
    /// - Parameters:
    ///   - record: SensingRecord，須存入本地資料庫的 SensingRecord 資料結構
    @objc optional func AddRecord(record: SensingRecord)
    
    /// 更新 SensingRecord 資料到資料庫
    /// - Parameters:
    ///   - record: SensingRecord，須存入本地資料庫的 SensingRecord 資料結構
    @objc optional func UpdateRecord(record: SensingRecord)
    
    /// 從資料庫取得指定時間區間的 SensingRecord 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 SensingRecord 資料，[SensingRecord]
    @objc optional func GetRecords(userID: String, startTime: Int64, endTime: Int64) -> [SensingRecord]
    
    /// 從資料庫取得單一時間的 SensingRecord 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - Time: Int64，查詢的時間
    /// - Returns: 從資料庫取出的 SensingRecord 資料，SensingRecord
    @objc optional func GetRecords(userID: String, Time: Int64) -> SensingRecord
    
    /// 新增 EventTable 資料到資料庫
    /// - Parameters:
    ///   - event: EventTable，須存入本地資料庫的 EventTable
    @objc optional func AddEvent(event: EventTable)
    
    /// 更新 EventTable 資料到資料庫
    /// - Parameters:
    ///   - event: EventTable，須存入本地資料庫的 EventTable
    @objc optional func UpdateEvent(event: EventTable)
    
    /// 從資料庫取得指定時間區間的 Event 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 EventTable 資料，[EventTable]
    @objc optional func GetEvents(userID: String, startTime: Int64, endTime: Int64) -> [EventTable]
    
    /// 新增 AlertTable 資料到資料庫
    /// - Parameters:
    ///   - alert: AlertTable，須存入本地資料庫的 AlertTable
    @objc optional func AddAlert(alert: AlertTable)
    

    /// 從資料庫取得指定時間區間的 AlertTable 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    ///   - startTime: Int64，查詢的啟始時間
    ///   - endTime: Int64，查詢的終止時間
    /// - Returns: 從資料庫取出的 AlertTable 資料，[AlertTable]
    @objc optional func GetAlerts(userID: String, startTime: Int64, endTime: Int64) -> [AlertTable]
    
    /// 新增 PersonalInfo 資料到資料庫
    /// - Parameters:
    ///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
    @objc optional func AddPersonalInfo(info: PersonalInfo)
    
    /// 更新 PersonalInfo 資料到資料庫
    /// - Parameters:
    ///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
    @objc optional func UpdatePersonalInfo(info: PersonalInfo)
    
    /// 從資料庫取得 PersonalInfo 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 PersonalInfo 資料，PersonalInfo
    @objc optional func GetPersonalInfo(userID: String) -> PersonalInfo
    
    /// 新增 PersonalDynamicInfo 記錄到資料庫
    /// - Parameters:
    ///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
    @objc optional func AddPersonDynamicInfo(info: PersonalDynamicInfo)
    
    /// 更新 PersonalDynamicInfo 記錄到資料庫
    /// - Parameters:
    ///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
    @objc optional func UpdatePersonDynamicInfo(info: PersonalDynamicInfo)
    
    /// 從資料庫取得 PersonalDynamicInfo 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 PersonalDynamicInfo 陣列，[PersonalDynamicInfo]
    @objc optional func GetPersonDynamicInfo(userID: String) -> [PersonalDynamicInfo]

    /// 更新 `血糖校正算法參數` 到資料庫
    /// - Parameters:
    ///   - event: GlucoseCorrectParam，須存入本地資料庫的 GlucoseCorrectParam
    @objc optional func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
    
    /// 從資料庫取得 GlucoseCorrectParam 資料
    /// - Parameters:
    ///   - userID: String，查詢的使用者 ID
    /// - Returns: 從資料庫取出的 GlucoseCorrectParam 資料
    @objc optional func GetGlucoseCorrectParam(userID: String) -> GlucoseCorrectParam
}
```

#### Function

```swift
// MARK: - SensingRecord

/// 新增 SensingRecord 的資料到本地資料庫
/// - Parameters:
///   - record: SensingRecord
public func AddRecord(record: SensingRecord)

/// 更新 SensingRecord 資料到資料庫
/// - Parameters:
///   - record: SensingRecord，須存入本地資料庫的 SensingRecord 資料結構
public func UpdateRecord(record: SensingRecord)

/// 從資料庫取得指定時間區間的 SensingRecord 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
///   - startTime: Int64，查詢的啟始時間
///   - endTime: Int64，查詢的終止時間
/// - Returns: 從資料庫取出的 SensingRecord 資料，[SensingRecord]
public func GetRecords(userID: String, startTime: Int64, endTime: Int64) -> [SensingRecord]

/// 從資料庫取得單一時間的 SensingRecord 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
///   - Time: Int64，查詢的時間
/// - Returns: 從資料庫取出的 SensingRecord 資料，SensingRecord
public func GetRecords(userID: String, Time: Int64) -> SensingRecord

// MARK: - EventTable

/// 新增 EventTable 資料到資料庫
/// - Parameters:
///   - event: EventTable，須存入本地資料庫的 EventTable
public func AddEvent(event: EventTable)

/// 更新 EventTable 資料到資料庫
/// - Parameters:
///   - event: EventTable，須存入本地資料庫的 EventTable
public func UpdateEvent(event: EventTable)

/// 從資料庫取得指定時間區間的 Event 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
///   - startTime: Int64，查詢的啟始時間
///   - endTime: Int64，查詢的終止時間
/// - Returns: 從資料庫取出的 EventTable 資料，[EventTable]
public func GetEvents(userID: String, startTime: Int64, endTime: Int64) -> [EventTable]

// MARK: - AlertTable

/// 新增 AlertTable 資料到資料庫
/// - Parameters:
///   - alert: AlertTable，須存入本地資料庫的 AlertTable
public func AddAlert(alert: AlertTable)

/// 從資料庫取得指定時間區間的 AlertTable 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
///   - startTime: Int64，查詢的啟始時間
///   - endTime: Int64，查詢的終止時間
/// - Returns: 從資料庫取出的 AlertTable 資料，[AlertTable]
public func GetAlerts(userID: String, startTime: Int64, endTime: Int64) -> [AlertTable]

// MARK: - PersonalInfo

/// 新增 PersonalInfo 資料到資料庫
/// - Parameters:
///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
public func AddPersonalInfo(info: PersonalInfo)

/// 更新 PersonalInfo 資料到資料庫
/// - Parameters:
///   - info: PersonalInfo，須存入本地資料庫的 PersonalInfo
public func UpdatePersonalInfo(info: PersonalInfo)

/// 從資料庫取得 PersonalInfo 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
/// - Returns: 從資料庫取出的 PersonalInfo 資料，PersonalInfo
public func GetPersonalInfo(userID: String) -> PersonalInfo

// MARK: - PersonalDynamicInfo

/// 新增 PersonalDynamicInfo 記錄到資料庫
/// - Parameters:
///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
public func AddPersonDynamicInfo(info: PersonalDynamicInfo)

/// 更新 PersonalDynamicInfo 記錄到資料庫
/// - Parameters:
///   - info: PersonalDynamicInfo，須存入本地資料庫的 PersonalDynamicInfo
public func UpdatePersonDynamicInfo(info: PersonalDynamicInfo)

/// 從資料庫取得 PersonalDynamicInfo 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
/// - Returns: 從資料庫取出的 PersonalDynamicInfo 陣列，[PersonalDynamicInfo]
public func GetPersonDynamicInfo(userID: String) -> [PersonalDynamicInfo]

// MARK: - GlucoseCorrectParam

/// 更新 `血糖校正算法參數` 到資料庫
/// - Parameters:
///   - event: GlucoseCorrectParam，須存入本地資料庫的 GlucoseCorrectParam
public func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)

/// 從資料庫取得 GlucoseCorrectParam 資料
/// - Parameters:
///   - userID: String，查詢的使用者 ID
/// - Returns: 從資料庫取出的 GlucoseCorrectParam 資料
public func GetGlucoseCorrectParam(userID: String) -> GlucoseCorrectParam
```

### Class SDK_Setting

#### Description

- Seknova iOS SDK 內部使用的 UserDefaults

#### Single Pattern

```swift
public static let shared = SDK_Setting()
```

#### Parameters

```swift
var defaultADC: String { get set }              // 顯示時 預設的血糖值

var username: String { get set }                // 使用者帳號

var password: String { get set }                // 使用者密碼

var isFirstLogin: Bool { get set }              // 是否為首次登入

var deviceID: String { get set }                // Transmiter ID

var sensorID: String { get set }                // Sensor ID

var sensorDate: String { get set }              // Sensor 啟用時間

var sensorBindingTimeStamp: Int64 { get set }   // Sensor 啟用時間

var isSensorOverride: Bool { get set }          // 紀錄 Sensor ID 是否已寫入成功

var firstRecordCount: String { get set }        // 第一筆 收到的血糖 index

var lastRecordCount: String { get set }         // 最後一筆 收到的血糖 index

var fwVersion: String { get set }               // 韌體版本

var lastTimeZoneNumber: Int { get set }         // 時區

var resetCount: Int { get set }                 // 裝置 reset 次數

var isWarmUpBool: Bool { get set }              // 裝置是否正在暖機

var isWarmUpTimeStamp: Int64 { get set }        // 裝置開始暖機的時間戳

var finishWarmUpTimeStamp: Int64 { get set }    // 裝置預計完成暖機的時間戳

var warmUpTime: Int { get set }                 // 暖機剩餘時間

var isCgmCanWriteCalibrate: Bool { get set }    // 紀錄 cgmStatus 回傳的 byte[10]，是否有禁用血糖校正功能

var isFirstCalibration: Bool { get set }        // 是否為第一次校正

var isCalibrated: Bool { get set }              // 是否完成校正

var calibrateValue: Int { get set }             // 欲校正的數值

var finishCalibrateTimeStamp: Int64 { get set } // 最後一筆完成校正時間戳

var nextCalibrateInterval: Int64 { get set }    // 下次預計校正時間 (間隔)

var RawData2BGBias: Int { get set }             // 血糖校正參數

var BGBias: Int { get set }                     // 血糖校正參數

var BGLow: Int { get set }                      // 血糖校正參數

var BGHigh: Int { get set }                     // 血糖校正參數

var MapRate: Int { get set }                    // 血糖校正參數

var ThresholdRise: Int { get set }              // 血糖校正參數

var ThresholdFall: Int { get set }              // 血糖校正參數

var RiseRate: Int { get set }                   // 血糖校正參數

var FallenRate: Int { get set }                 // 血糖校正參數
```

### Class DataCorrectionAlgo

#### Description

- 處理本地校正算法的類別

#### Single Pattern

```swift
public static let share = DataCorrectionAlgo()
```

#### Function

```swift
/// 更新血糖校正算法
public func UpdateAlgoParam(param: GlucoseCorrectParam)

/// 進行血糖校正算法
public func GlucoseCorrect(records: [SensingRecord]) -> SensingRecord
```

---

## 雲端 API 類別

### Class CloudParseManager

#### Description

- 協助處理 Web Restful API 的類別
- 幫忙轉換上傳的 JSON
- Parse 回傳的 JSON 結果

#### Function

```swift
/// 轉換 CmdType=1 上傳的 JSON Format
/// - Parameters:
///   - input: [SensingRecord]
/// - Returns: CmdType=1 的 JSON
public func GetJsonDataReport(input: [SensingRecord]) -> Data?

/// 轉換 CmdType=2 上傳的 JSON Format
/// - Parameters:
///   - input: EventTable
/// - Returns: CmdType=2 的 JSON
public func GetJsonEventReport(input: EventTable) -> Data?

/// 轉換 CmdType=8 (Delete Event) 上傳的 JSON Format
/// - Parameters:
///   - input: EventTable
/// - Returns: CmdType=8 的 JSON
public func GetJsonDeleteEvent(input: EventTable) -> Data?

/// 轉換 CmdType=0 上傳的 JSON Format
/// - Parameters:
///   - input: AlertTable
/// - Returns: CmdType=0 的 JSON
public func GetJsonAlertReport(input: AlertTable) -> Data?

/// 轉換 CmdType=11 (Add User Info) 上傳的 JSON Format
/// - Parameters:
///   - input: PersonalInfo
/// - Returns: CmdType=11 的 JSON
public func GetJsonAddUserInfo(input: PersonalInfo) -> Data?

/// 轉換 CmdType=12 (Add User Dynamic) 上傳的 JSON Format
/// - Parameters:
///   - input: PersonalDynamicInfo
/// - Returns: CmdType=12 的 JSON
public func GetJsonAddUserDynamicInfo(input: PersonalDynamicInfo) -> Data?

/// Parse Web API CmdType=13 的 Response JSON
/// - Parameters:
///   - jsonRsp: SDK_GetUserProfileResponse?
/// - Returns: PersonalInfo 的資料結構，PersonalInfo
public func ParseRspUserInfo(jsonRsp: SDK_GetUserProfileResponse?) -> PersonalInfo

/// Parse Web API CmdType=27 (Get Event ID) 的 Response JSON
/// - Parameters:
///   - jsonRsp: SDK_GetEventResponse?
/// - Returns: EventTable 的 Array，[EventTable]
public func ParseRspGetEventsReport(jsonRsp: SDK_GetEventResponse?) -> [EventTable]
```

#### Response Parse Struct

```swift
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
```

---

## SDK 內所使用的 Extension

### Extension - Data

```swift
public extension Data {
    
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
```

### Extension - String

```swift
public extension String {
    
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
```

### Extension - Int

```swift
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
```

### Extension - Int64

```swift
public extension Int64 {
    
    func timeStampToDate() -> Date {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
    
}
```

### Extension - Encodable

```swift
public extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        
        return dictionary
    }
    
}
```

### Extension - Date

```swift
public extension Date {
    
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
```

### Extension - Array

```swift
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
    
    /// 刪除陣列裡多筆指定的資料
    mutating func removeSpecifiedIndices(_ indices: [Int]) {
        let sortedIndices = indices.sorted().reversed()
        for i in sortedIndices {
            guard i < count else { return }
            remove(at: i)
        }
    }
    
    /// 刪除陣列裡資料 (任何型別)
    mutating func delete(element: AnyObject) {
        self = self.filter() { $0 as AnyObject !== element as AnyObject }
    }

}
```

### Extension - Realm

```swift
public extension Realm {
    
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
    
}
```

---

## 將 Seknova iOS SDK 與您的專案項目整合

![SDK 流程圖](https://i.imgur.com/oJVG1TM.png)

在 Podfile 裡面輸入下方內容，來安裝 Seknova iOS SDK

```ruby
# 安裝最新版本的 SeknovaSDK
pod 'SeknovaSDK'

# 安裝指定版本的 SeknovaSDK
pod 'SeknovaSDK', '<指定版本的版號>'
```

SDK 連結：[CocoaPods](https://cocoapods.org/pods/SeknovaSDK) &emsp; [GitHub](https://github.com/leoho0722/SeknovaSDK)

## 與 Seknova 藍牙 SDK 進行串接

在外部開發者您自己建立的 Class BluetoothService 內 
import CoreBluetooth，這個由 Apple 提供的原生藍牙處理 Framework，
以及 import SeknovaSDK
並讓您的 BluetoothService 繼承 ```CBCentralManagerDelegate``` 這個 Protocol 且實作相關 Function

```swift 
import Foundation
import CoreBluetooth
import SeknovaSDK

class BluetoothService: NSObject, CBCentralManagerDelegate {
    // Your BluetoothService Code ...
}
```

並在該 Protocol 所提供的這個 Function 內，將 peripheral.delegate 委任給 Seknova 藍牙 SDK，
並繼承 Seknova 藍牙 SDK 的 Protocol ```BluetoothDelegateListener``` 且實作相關 Function

#### Sample Code

```swift
func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    // Your Other Code ...
    peripheral.delegate = SDK_BluetoothService.shareInstance
    SDK_BluetoothService.shareInstance.delegate = self
    // Your Other Code ...
}
```

```swift
extension BluetoothService: BluetoothDelegateListener {

    func HandlePeripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
    }
    
    func HandlePeripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristicsFor")
    }
    
    func HandlePeripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateValueFor")
    }
    
    func HandlePeripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didWriteValueFor")
    }

    func EventCallback(eventID: Int, value: Int) {
        switch eventID {
          case 1:
            // Handle EventCallback.eventID = 1
          case 2:
            // Handle EventCallback.eventID = 2
          case 3:
            // Handle EventCallback.eventID = 3
          case 4:
            // Handle EventCallback.eventID = 4
          case 5:
            // Handle EventCallback.eventID = 5
          case 6:
            // Handle EventCallback.eventID = 6
          default:
            break
        }
    }
}
```

## 在各畫面所使用到的 SDK Function

### 登入畫面

<img src="https://i.imgur.com/oZTD2WX.png" width = "310.5" height = "672" alt="登入畫面" align=center />

#### 登入畫面所使用到的 SDK Function 如下

```swift
/// Email 登入
/// - Parameters:
///   - username: String，使用者帳號
///   - password: String，使用者設定的密碼
///   - finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void
///     - SignInResult?，使用者登入的結果
///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
///     - Error?，AWSMobileClientError
///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserSignIn(username: String, password: String, finish: @escaping(SignInResult?, String?, Error?, UInt8) -> Void)
```

```swift
/// 第三方登入
/// - Parameters:
///   - hostedUIOption: HostedUIOptions，第三方登入提供商
///   - navigationController: UINavigationController，用來呈現第三方登入頁面的
///   - finish: @escaping(UserState?, String?, Error?, UInt8)
///     - UserState?，AWS Cognito 使用者登入狀態
///     - String?，從 AWSMobileClient.default().getTokens 取得的 token
///     - Error?，AWSMobileClientError
///     - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ShowSignIn(hostedUIOption: HostedUIOptions, navigationController: UINavigationController, finish: @escaping(UserState?, String?, Error?, UInt8) -> Void)
```

```swift
/// 取得使用者紀錄的屬性
/// - Parameters:
///    - finish: @escaping([String: String]?, Error?) -> Void
///      - [String: String]?，使用者在 AWS 上的屬性
///      - Error?，AWSMobileClientError
public func GetAttribute(finish: @escaping([String: String]?, Error?) -> Void)
```

```swift
/// 新增使用者資訊
/// - Parameters:
///   - info: PersonalInfo
public func AddPersonalInfo(info: PersonalInfo)
```

```swift
/// 新增/更新使用者的校正參數
/// - Parameters:
///   - event: GlucoseCorrectParam
public func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
```

<!--

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

-->

#### Sample Code

```swift
// Email 登入
AccountManager().UserSignIn(username: SDK_Setting.shared.username, password: SDK_Setting.shared.password) { signInResult, token, error, signInState  in
    if error != nil && signInState == 1 {
        // Handle Error 
    } else if error == nil && signInState == 0 {
        // Handle SignIn Success
    }
}
```

```swift
// 第三方登入：Sign In With Apple
let hostedUIOptions = HostedUIOptions(identityProvider: "SignInWithApple")
AccountManager().ShowSignIn(hostedUIOption: hostedUIOptions, navigationController: self.navigationController!) { userState, token, error, signInState in
    if (error != nil && signInState == 1) {
        // Handle Error
    } else if (error == nil && signInState == 0) {
        // Handle Sign In Success
    } else {
        // Handle Other Event
    }
}
```

```swift
// 取得使用者紀錄的屬性
AccountManager().GetAttribute { attributedata, error in
    print("email:", attributedata?["email"] ?? "error@seknova.com")
    let email = attributedata?["email"] ?? "error@seknova.com"
    let identiites = attributedata?["identities"] ?? ""
    print("identiites:", identiites)
}
```

```swift
// 新增使用者資訊
let personalInfo = PersonalInfo()
personalInfo.UserID = SDK_Setting.shared.username
personalInfo.fname = "Seknova"
personalInfo.lname = "SDK"
personalInfo.birth = "2022/05/27"
personalInfo.phone = "0912345678"
personalInfo.address = "Seknova"
personalInfo.gender = 0
personalInfo.height = 170
personalInfo.weight = 68
personalInfo.ethnic = 0
personalInfo.drink = 0
personalInfo.smoke = false
personalInfo.IsPhoneBinding = false
personalInfo.Check = false
LocalDatabase.shared.AddPersonalInfo(info: personalInfo)
```

```swift
// 新增/更新使用者的校正參數
let GlucoseCorrectParam = GlucoseCorrectParam()
GlucoseCorrectParam.ModeID = ModeID
GlucoseCorrectParam.RawData2BGBias = RawData2BGBias
GlucoseCorrectParam.BGBias = BGBias
GlucoseCorrectParam.BGLow = BGLow
GlucoseCorrectParam.BGHigh = BGHigh
GlucoseCorrectParam.MapRate = MappingRate
GlucoseCorrectParam.ThresholdRise = Int(ThresholdRise) ?? 50
GlucoseCorrectParam.ThresholdFall = Int(ThresholdFall) ?? 50
GlucoseCorrectParam.RiseRate = Int(RiseRate) ?? 100
GlucoseCorrectParam.FallenRate = Int(FallenRate) ?? 100
LocalDatabase.shared.UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
```

<!--

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

-->

### 註冊畫面

<img src="https://i.imgur.com/qPjyDYm.png" width = "310.5" height = "672" alt="註冊畫面" align=center />

#### 註冊畫面所使用到的 SDK Function 如下

```swift
/// 使用者註冊
/// - Parameters:
///    - username: String，使用者帳號
///    - password: String，使用者設定的密碼
///    - locale: String，使用者設定的國籍
///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
///      - SignUpResult?，使用者註冊的結果
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserSignUp(username: String, password: String, locale: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void)
```

#### Sample Code

```swift
AccountManager().UserSignUp(username: usernameTF.text!, password: passwordTF.text!, locale: countryLab.text!) { signUpResult, error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle SignUp Success
    }
}
```

### 開通帳號畫面

<img src="https://i.imgur.com/oRgXANz.png" width = "310.5" height = "672" alt="開通帳號畫面" align=center />

#### 開通帳號畫面所使用到的 SDK Function 如下

```swift
/// 使用者驗證
/// - Parameters:
///    - username: String，使用者帳號
///    - finish: @escaping(SignUpResult?, Error?, UInt8) -> Void
///      - SignUpResult?，使用者重送驗證信的結果
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ResendSignUpVerifyCode(username: String, finish: @escaping(SignUpResult?, Error?, UInt8) -> Void)
```

#### Sample Code

```swift
AccountManager().ResendSignUpVerifyCode(username: username) { result, error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle ResendSignUpVerifyCode Success
    }
}
```

### 忘記密碼畫面

<img src="https://i.imgur.com/ttU9Ic1.jpg" width = "310.5" height = "672" alt="忘記密碼畫面" align=center />

#### 忘記密碼畫面所使用到的 SDK Function 如下

```swift
/// 使用者忘記密碼觸發驗證碼發送
/// - Parameters:
///   - username: String，使用者帳號
///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
///      - ForgotPasswordResult?，忘記密碼的資料
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ForgotPassword(username: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void)
```

#### Sample Code

```swift
AccountManager().ForgotPassword(username: usernameTF.text!) { forgotPasswordResult, error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle ForgotPassword Success
    } else {
      // Handle Other Event
    }
}
```

### 重設密碼畫面

<img src="https://i.imgur.com/PK81P3z.png" width = "310.5" height = "672" alt="重設密碼畫面" align=center />

#### 重設密碼畫面所使用到的 SDK Function 如下

```swift
/// 使用者忘記密碼重新設定
/// - Parameters:
///   - username: String，使用者帳號
///   - newPassword: String，使用者新設定的密碼
///   - confirmCode: String，確認驗證碼
///   - finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void
///      - ForgotPasswordResult?，忘記密碼的資料
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ComfirmForgotPassword(username: String, newPassword: String, confirmCode: String, finish: @escaping(ForgotPasswordResult?, Error?, UInt8) -> Void)
```

#### Sample Code

```swift
AccountManager().ComfirmForgotPassword(username: usernameTF.text!, newPassword: newpasswordTF.text!, confirmCode: code) { forgotPasswordResult, error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle ConfirmForgotPassword Success
    } else {
      // Handle Other Event
    }
}
```

### 綁定手機畫面

<img src="https://i.imgur.com/GOpkueK.png" width = "310.5" height = "672" alt="綁定手機畫面" align=center />

#### 綁定手機畫面所使用到的 SDK Function 如下

```swift
/// 更新使用者屬性
/// - Parameters:
///   - input: [String: String]
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UpdateAttribute(input: [String: String], finish: @escaping(Error?, UInt8) -> Void)
```

```swift
/// 使用者手機驗證碼輸入
/// - Parameters:
///   - username: String，使用者帳號
///   - code: String，6 碼驗證碼
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func ConfirmVerifyUser(username: String, code: String, finish: @escaping(Error?, UInt8) -> Void)
```

#### Sample Code

```swift
AccountManager().UpdateAttribute(input: newUserAttributes) { error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle Update Phone Attribute Success
    }
}
```

```swift
AccountManager().ConfirmVerifyUser(username: GlobalAppSetting.shared.username, code: code) { error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle ConfirmVerifyUser Success
    }
}
```

### 個人資訊畫面

<img src="https://i.imgur.com/0aC71zs.png" width = "310.5" height = "672" alt="個人資訊畫面" align=center />

#### 個人資訊畫面所使用到的 SDK Function 如下

```swift
/// 使用者登出
public func UserSignOut()

public func saveRecordCountData()
DB_PersonalInfo

SDK_Setting.shared.username
SDK_Setting.shared.deviceID
SDK_Setting.shared.sensorID
SDK_Setting.shared.sensorDate
SDK_Setting.shared.lastRecordCount
SDK_Setting.shared.firstRecordCount
SDK_Setting.shared.resetCount
SDK_Setting.shared.isWarmUpTimeStamp
SDK_Setting.shared.isWarmUpBool
SDK_Setting.shared.isCalibrated
SDK_Setting.shared.finishCalibrateTimeStamp
SDK_Setting.shared.nextCalibrateInterval
SDK_Setting.shared.sensorBindingTimeStamp
```

#### Sample Code

```swift
AccountManager().UserSignOut()
```

```swift
LocalDatabase.shared.saveRecordCountData()
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_PersonalInfo.self)
```

### 修改密碼畫面

<img src="https://i.imgur.com/Ui7yDhK.png" width = "310.5" height = "672" alt="修改密碼畫面" align=center />

#### 修改密碼畫面所使用到的 SDK Function 如下

```swift
/// 使用者修改密碼
/// - Parameters:
///   - username: String，使用者帳號
///   - currentPassword: String，使用者目前的密碼
///   - newPassword: String，使用者新設定的密碼
///   - finish: @escaping(Error?, UInt8) -> Void
///      - Error?，AWSMobileClientError
///      - UInt8，signInState: 0 = Success，1 = Error (No specific error description)
public func UserChangePassword(username: String, currentPassword: String, newPassword: String, finish: @escaping(Error?, UInt8) -> Void)

SDK_Setting.shared.username
```

#### Sample Code

```swift
AccountManager().UserChangePassword(username: SDK_Setting.shared.username, currentPassword: passwordTF.text!, newPassword: newpasswordTF.text!) { error, signInState in
    if (error != nil && signInState == 1) {
      // Handle Error
    } else if (error == nil && signInState == 0) {
      // Handle UserChangePassword Success
    }
}
```

### 身體資訊蒐集畫面

<img src="https://i.imgur.com/idgeh63.png" width = "310.5" height = "672" alt="身體資訊蒐集畫面" align=center />

#### 身體資訊蒐集畫面所使用到的 SDK Function 如下

```swift
/// 新增使用者資訊
/// - Parameters:
///   - info: PersonalInfo
public func AddPersonalInfo(info: PersonalInfo)
```

#### Sample Code

```swift
let personalInfo = PersonalInfo()
personalInfo.UserID = SDK_Setting.shared.username
personalInfo.fname = "Seknova"
personalInfo.lname = "SDK"
personalInfo.birth = "2022/05/27"
personalInfo.phone = "0912345678"
personalInfo.address = "Seknova"
personalInfo.gender = 0
personalInfo.height = 170
personalInfo.weight = 68
personalInfo.ethnic = 0
personalInfo.drink = 0
personalInfo.smoke = false
personalInfo.IsPhoneBinding = false
personalInfo.Check = false
LocalDatabase.shared.AddPersonalInfo(info: personalInfo)
```

### 啟用發射器畫面

<img src="https://i.imgur.com/T99z057.png" width = "310.5" height = "672" alt="啟用發射器畫面" align=center />

#### 啟用發射器畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.deviceID // 發射器 ID
```

#### Sample Code

```swift
SDK_Setting.shared.deviceID = "SK0xE05124\(textfield.text!.uppercased())"
```

### 配對發射器畫面

<img src="https://i.imgur.com/FtFyLfn.png" width = "310.5" height = "672" alt="配對發射器畫面" align=center />

#### 配對發射器畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.deviceID
SDK_Setting.shared.isWarmUpBool
SDK_Setting.shared.isCalibrated
SDK_Setting.shared.nextCalibrateInterval
SDK_Setting.shared.isWarmUpTimeStamp
SDK_Setting.shared.finishWarmUpTimeStamp
```

#### Sample Code

```swift
SDK_Setting.shared.deviceID = deviceID
SDK_Setting.shared.isWarmUpBool = true
SDK_Setting.shared.isCalibrated = false
SDK_Setting.shared.nextCalibrateInterval = 2 * 60 * 60 * 1000
SDK_Setting.shared.isWarmUpTimeStamp = now.millisecondsSince1970
SDK_Setting.shared.finishWarmUpTimeStamp = -1
```

### 發射器連線中畫面

<img src="https://i.imgur.com/sIyXyk5.png" width = "310.5" height = "672" alt="發射器連線中畫面" align=center />

#### 發射器連線中畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.deviceID
```

#### Sample Code

```swift
SDK_Setting.shared.deviceID = ""
```

### 啟用感測器畫面

<img src="https://i.imgur.com/zfdRDqL.png" width = "310.5" height = "672" alt="啟用感測器畫面" align=center />

#### 啟用感測器畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.sensorID
```

#### Sample Code

```swift
SDK_Setting.shared.sensorID = "SK0xS\(textfield.text!.uppercased())"
```

### 即時血糖畫面

<img src="https://i.imgur.com/D0jGu3F.png" width = "310.5" height = "672" alt="即時血糖畫面" align=center />

#### 即時血糖畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.defaultADC
SDK_Setting.shared.isCalibrated
SDK_Setting.shared.warmUpTime
SDK_Setting.shared.isWarmUpBool
SDK_Setting.shared.finishWarmUpTimeStamp
SDK_Setting.shared.finishCalibrateTimeStamp
SDK_Setting.shared.nextCalibrateInterval
SDK_Setting.shared.username 
SDK_Setting.shared.deviceID
SDK_Setting.shared.sensorID
SDK_Setting.shared.lastRecordCount
SDK_Setting.shared.isWarmUpTimeStamp
SDK_Setting.shared.sensorDate
SDK_Setting.shared.isCgmCanWriteCalibrate
SDK_Setting.shared.lastTimeZoneNumber

public func AddRecord(record: SensingRecord)
public func AddAlert(alert: AlertTable)
public func changeRecordDisplayTime()
public func saveRecordCountData()
DB_SensingRecord
DB_AlertTable

func int2StrBinary() -> String         // public extension Int
func int2StrHex8() -> String           // public extension Int
func timeStampToDate() -> Date         // public extension Int64

func strHex2Int() -> Int               // public extension String
func shiftUtc2LocalTZ() -> String      // public extension String
func str2Date() -> Date                // public extension String

var millisecondsSince1970: Int64       // public extension Date
func convert2LocalTZUtcStr() -> String // public extension Date
func convert2UtcStr() -> String        // public extension Date
```

#### Sample Code

```swift
let sensingRecord = SensingRecord()
sensingRecord.Timestamp = (self.lastUploadRecordTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
sensingRecord.IndexID = startIndex
sensingRecord.RawData = rawADC
sensingRecord.CalibrationData = [self.adc]
sensingRecord.Temperature = self.temp
sensingRecord.Trend = 0
sensingRecord.RSSI = self.rssi
sensingRecord.Battery = self.battery
sensingRecord.SensorID = SDK_Setting.shared.sensorID
sensingRecord.UserID = SDK_Setting.shared.username
sensingRecord.Check = isCheck
sensingRecord.isDisplay = update
LocalDatabase.shared.AddRecord(record: sensingRecord)
```

```swift
let alertTable = AlertTable()
alertTable.AlertID = errorCode
alertTable.AlertValue = 1
alertTable.Timestamp = (time.millisecondsSince1970)/1000
alertTable.Check = false
LocalDatabase.shared.AddAlert(alert: alertTable)
```

```swift
LocalDatabase.shared.changeRecordDisplayTime()

LocalDatabase.shared.saveRecordCountData()
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_SensingRecord.self)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_AlertTable.self)
```

### 血糖校正確認畫面

<img src="https://i.imgur.com/0kfGD7M.jpg" width = "310.5" height = "672" alt="血糖校正確認畫面" align=center />

#### 血糖校正確認畫面所使用到的 SDK Function 如下

```swift
SDK_Setting.shared.deviceID
SDK_Setting.shared.username
SDK_Setting.shared.finishCalibrateTimeStamp
SDK_Setting.shared.nextCalibrateInterval
SDK_Setting.shared.isWarmUpBool
SDK_Setting.shared.isCalibrated
SDK_Setting.shared.isWarmUpTimeStamp
SDK_Setting.shared.isFirstCalibration

public func AddEvent(event: EventTable)
public func setCalibration(calibration: Int)

var millisecondsSince1970: Int64 // public extension Date
```

#### Sample Code

```swift
let eventTable = EventTable()
eventTable.Index = 0
eventTable.TimeStamp = recordTime.str2Date().millisecondsSince1970
eventTable.EventID = 1
eventTable.EventValue = self.calibrateValue ?? 50
eventTable.EventAttribute = self.eventAttribute
eventTable.Note = ""
eventTable.Check = true
LocalDatabase.shared.AddEvent(event: eventTable)
```

```swift
SDK_BluetoothService.shareInstance.setCalibration(calibration: self.calibrateValue ?? 50)
```

### 生活作息畫面

<img src="https://i.imgur.com/oaesgPY.png" width = "310.5" height = "672" alt="生活作息畫面" align=center />

#### 生活作息畫面所使用到的 SDK Function 如下

```swift
public func AddEvent(event: EventTable)
DB_EventTable

func timeStampToDate() -> Date    // public extension Int64

func shiftUtc2LocalTZ() -> String // public extension String
func shiftLocalTZ2Utc() -> String // public extension String
func str2Date() -> Date           // public extension String

var millisecondsSince1970: Int64  // public extension Date
func convert2UtcStr() -> String   // public extension Date

SDK_Setting.shared.deviceID
SDK_Setting.shared.username
```

#### Sample Code

```swift
let eventTable = EventTable()
eventTable.Index = 0
eventTable.TimeStamp = (utcTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
eventTable.EventID = 2
eventTable.EventValue = 0
eventTable.EventAttribute = ["蛋餅", "1", "好吃"]
eventTable.Note = "好吃"
eventTable.Check = false
LocalDatabase.shared.AddEvent(event: eventTable)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_EventTable.self).filter("Check = false")
let newResult: [DB_EventTable] = results.map { $0 }
```

### 事件記錄畫面

<img src="https://i.imgur.com/LJcNDUY.png" width = "310.5" height = "672" alt="事件記錄畫面" align=center />

#### 事件記錄畫面所使用到的 SDK Function 如下

```swift
public func AddEvent(event: EventTable)
DB_EventTable

func timeStampToDate() -> Date    // public extension Int64

func shiftUtc2LocalTZ() -> String // public extension String
func shiftLocalTZ2Utc() -> String // public extension String
func str2Date() -> Date           // public extension String

var millisecondsSince1970: Int64  // public extension Date
func convert2UtcStr() -> String   // public extension Date

SDK_Setting.shared.username
```

#### Sample Code

```swift
let eventTable = EventTable()
eventTable.Index = 36210
eventTable.TimeStamp = (utcTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
eventTable.EventID = 2
eventTable.EventValue = 0
eventTable.EventAttribute = ["蛋餅", "1", "好吃"]
eventTable.Note = "好吃"
eventTable.Check = true
LocalDatabase.shared.AddEvent(event: eventTable)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_EventTable.self)
let newResult: [DB_EventTable] = results.map { $0 }
```

### 歷史紀錄畫面

<img src="https://i.imgur.com/pa1rZJ9.png" width = "310.5" height = "672" alt="歷史紀錄畫面" align=center />

#### 歷史紀錄畫面所使用到的 SDK Function 如下

```swift
public func AddRecord(record: SensingRecord)
public func AddEvent(event: EventTable)
DB_SensingRecord
DB_EventTable

func timeStampToDate() -> Date         // public extension Int64

func shiftUtc2LocalTZ() -> String      // public extension String
func shiftLocalTZ2Utc() -> String      // public extension String
func str2Date() -> Date                // public extension String
func str2Double() -> Double            // public extension String

var millisecondsSince1970: Int64       // public extension Date
func convert2UtcStr() -> String        // public extension Date
func convert2LocalTZUtcStr() -> String // public extension Date

SDK_Setting.shared.username
```

#### Sample Code

```swift
let sensingRecord = SensingRecord()
sensingRecord.Timestamp = (self.lastUploadRecordTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
sensingRecord.IndexID = startIndex
sensingRecord.RawData = rawADC
sensingRecord.CalibrationData = [self.adc]
sensingRecord.Temperature = self.temp
sensingRecord.Trend = 0
sensingRecord.RSSI = self.rssi
sensingRecord.Battery = self.battery
sensingRecord.SensorID = SDK_Setting.shared.sensorID
sensingRecord.UserID = SDK_Setting.shared.username
sensingRecord.Check = isCheck
sensingRecord.isDisplay = update
LocalDatabase.shared.AddRecord(record: sensingRecord)
```

```swift
let eventTable = EventTable()
eventTable.Index = 36210
eventTable.TimeStamp = (utcTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
eventTable.EventID = 2
eventTable.EventValue = 0
eventTable.EventAttribute = ["蛋餅", "1", "好吃"]
eventTable.Note = "好吃"
eventTable.Check = true
LocalDatabase.shared.AddEvent(event: eventTable)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_SensingRecord.self)
let newResult: [DB_SensingRecord] = results.map { $0 }
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_EventTable.self)
let newResult: [DB_EventTable] = results.map { $0 }
```

### 設定畫面

<img src="https://i.imgur.com/RPHjHfb.png" width = "310.5" height = "672" alt="設定畫面" align=center />

#### 設定畫面所使用到的 SDK Function 如下

```swift
public func AddRecord(record: SensingRecord)
public func AddEvent(event: EventTable)
DB_SensingRecord
DB_EventTable

func shiftUtc2LocalTZ() -> String // public extension String
func shiftLocalTZ2Utc() -> String // public extension String
func str2Date() -> Date           // public extension String
func str2Double() -> Double       // public extension String

var millisecondsSince1970: Int64  // public extension Date

SDK_Setting.shared.username
SDK_Setting.shared.isWarmUpBool
SDK_Setting.shared.isWarmUpTimeStamp
SDK_Setting.shared.finishWarmUpTimeStamp
```

#### Sample Code

```swift
let sensingRecord = SensingRecord()
sensingRecord.Timestamp = (self.lastUploadRecordTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
sensingRecord.IndexID = startIndex
sensingRecord.RawData = rawADC
sensingRecord.CalibrationData = [self.adc]
sensingRecord.Temperature = self.temp
sensingRecord.Trend = 0
sensingRecord.RSSI = self.rssi
sensingRecord.Battery = self.battery
sensingRecord.SensorID = SDK_Setting.shared.sensorID
sensingRecord.UserID = SDK_Setting.shared.username
sensingRecord.Check = isCheck
sensingRecord.isDisplay = update
LocalDatabase.shared.AddRecord(record: sensingRecord)
```

```swift
let eventTable = EventTable()
eventTable.Index = 36210
eventTable.TimeStamp = (utcTime.shiftUtc2LocalTZ().str2Date().millisecondsSince1970)/1000
eventTable.EventID = 2
eventTable.EventValue = 0
eventTable.EventAttribute = ["蛋餅", "1", "好吃"]
eventTable.Note = "好吃"
eventTable.Check = true
LocalDatabase.shared.AddEvent(event: eventTable)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_SensingRecord.self)
let newResult: [DB_SensingRecord] = results.map { $0 }
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_EventTable.self)
let newResult: [DB_EventTable] = results.map { $0 }
```

### 設定校正模式畫面

<img src="https://i.imgur.com/1nYNpgb.png" width = "310.5" height = "672" alt="設定校正模式畫面" align=center />

#### 設定校正模式畫面所使用到的 SDK Function 如下

```swift
public func UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
DB_GlucoseCorrectParam
```

#### Sample Code

```swift
let GlucoseCorrectParam = GlucoseCorrectParam()
GlucoseCorrectParam.ModeID = 0
GlucoseCorrectParam.RawData2BGBias = 100
GlucoseCorrectParam.BGBias = 100
GlucoseCorrectParam.BGLow = 40
GlucoseCorrectParam.BGHigh = 400
GlucoseCorrectParam.MapRate = 1
GlucoseCorrectParam.ThresholdRise = 50
GlucoseCorrectParam.ThresholdFall = 50
GlucoseCorrectParam.RiseRate = 100
GlucoseCorrectParam.FallenRate = 100
LocalDatabase.shared.UpdateGlucoseCorrectParam(event: GlucoseCorrectParam)
```

```swift
let realm = try! Realm()
let results = realm.objects(DB_GlucoseCorrectParam.self)
```

---

## 未在專案內所使用的 SDK Function

### CloudParseManager

#### Function

```swift
/// 轉換 CmdType=1 上傳的 JSON Format
/// - Parameters:
///   - input: [SensingRecord]
/// - Returns: CmdType=1 的 JSON
public func GetJsonDataReport(input: [SensingRecord]) -> Data?

/// 轉換 CmdType=2 上傳的 JSON Format
/// - Parameters:
///   - input: EventTable
/// - Returns: CmdType=2 的 JSON
public func GetJsonEventReport(input: EventTable) -> Data?

/// 轉換 CmdType=8 (delete event) 上傳的 JSON Format
/// - Parameters:
///   - input: EventTable
/// - Returns: CmdType=8 的 JSON
public func GetJsonDeleteEvent(input: EventTable) -> Data?

/// 轉換 CmdType=0 上傳的 JSON Format
/// - Parameters:
///   - input: AlertTable
/// - Returns: CmdType=0 的 JSON
public func GetJsonAlertReport(input: AlertTable) -> Data?

/// 轉換 CmdType=11 (Add User Info) 上傳的 JSON Format
/// - Parameters:
///   - input: PersonalInfo
/// - Returns: CmdType=11 的 JSON
public func GetJsonAddUserInfo(input: PersonalInfo) -> Data?

/// 轉換 CmdType=12 (Add User Dynamic) 上傳的 JSON Format
/// - Parameters:
///   - input: PersonalDynamicInfo
/// - Returns: CmdType=12 的 JSON
public func GetJsonAddUserDynamicInfo(input: PersonalDynamicInfo) -> Data?

/// Parse Web API CmdType=13 的 Response JSON
/// - Parameters:
///   - jsonRsp: SDK_GetUserProfileResponse?
/// - Returns: PersonalInfo 的資料結構，PersonalInfo
public func ParseRspUserInfo(jsonRsp: SDK_GetUserProfileResponse?) -> PersonalInfo

/// Parse Web API CmdType=27 (Get Event ID) 的 Response JSON
/// - Parameters:
///   - jsonRsp: SDK_GetEventResponse?
/// - Returns: EventTable 的 array，[EventTable]
public func ParseRspGetEventsReport(jsonRsp: SDK_GetEventResponse?) -> [EventTable]
```

#### Response Parse Struct

```swift
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
```