//
//  SDK_BluetoothService.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/3/14.
//  Copyright © 2022 鈞. All rights reserved.
//

import UIKit
import CoreBluetooth
import CryptoSwift

public class SDK_BluetoothService: NSObject {
    
    public static let shareInstance = SDK_BluetoothService()
    
    public var delegate: BluetoothDelegateListener?
    
    let commandBase = SDK_CommandBase.shareInstance

    // MARK: - Basic
    
    var blePeripheral: CBPeripheral!
    
    var targetCharacteristic: CBCharacteristic!
    
    var queryCharacteristic: CBCharacteristic! // FFF2
    
    var coverCharacteristic: CBCharacteristic! // FFF3
    
    var adcCharacteristic: CBCharacteristic! // FFF4
    
    var utcInfoCharacteristic: CBCharacteristic! // FFF5
    
    var measurementCharacteristic: CBCharacteristic! // 2AA7
    
    var statusCharacteristic: CBCharacteristic! // 2AA9
    
    var sessionStartTimeCharacteristic: CBCharacteristic! // 2AAA
    
    var sessionRunTimeCharacteristic: CBCharacteristic! // 2AAB
    
    var accessControlCharacteristic: CBCharacteristic! // 2A52
    
    var specificOpsControl: CBCharacteristic! // 2CCA
    
    public let uuid = CBUUID(string: "181f") // FFF4 的 service UUID
    
    let b_2aa8 = CBUUID(string: "2aa8") // FFF4 的 characteristic UUID 裝置資訊 & 參數 (原 uuid1)
    
    let uuid2 = CBUUID(string: "fff2") // FFF4 的 characteristic UUID 要求資料回補
    
    let uuid3 = CBUUID(string: "fff3") // FFF4 的 characteristic UUID 資料回補
    
    let uuid4 = CBUUID(string: "fff4") // FFF4 的 characteristic UUID ADC回傳
    
    let uuid5 = CBUUID(string: "fff5") // FFF4 的 characteristic UUID UTC時間
    
    let b_2aa7 = CBUUID(string: "2aa7") // 量測資訊回傳
    
    let b_2aa9 = CBUUID(string: "2aa9") // CGM 狀態
    
    let b_2aaa = CBUUID(string: "2aaa") // 啟用時間
    
    let b_2aab = CBUUID(string: "2aab") // 當前時間
    
    let b_2a52 = CBUUID(string: "2a52") // 資料存取控制
    
    let b_2cca = CBUUID(string: "2cca") // 修改參數、回報結果
    
    var battery: Int?
    
    // MARK: - 回補資料
    
    var syncCoverBool = false
    
    var coverIdArray = [Int]()
    
    var singleCover = singleCoverStruct()
    
    struct singleCoverStruct {
        var index: Int?
        var count: Int?
    }
    
    // MARK: - 回傳資料
    
    var transmitterInfo: TransmitterInfo?
    
    var currentRecordInfo: SensingRecord?

    var oldRecordInfo: [SensingRecord]?

    var sensorInfo: SensorInfo?
    
}


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
