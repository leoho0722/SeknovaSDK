//
//  SDK_BluetoothManager.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/3/14.
//  Copyright © 2022 鈞. All rights reserved.
//

import UIKit
import CoreBluetooth
import CryptoSwift

extension SDK_BluetoothService: CBPeripheralDelegate {
    
    // MARK: - BLE 發現 Services 的處理函數
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        delegate?.HandlePeripheral(peripheral, didDiscoverServices: error)
        
        // 資料初始化
        transmitterInfo = TransmitterInfo()
        coverIdArray = [Int]()
        
        currentRecordInfo = SensingRecord()
        oldRecordInfo = [SensingRecord]()
        
        blePeripheral = peripheral
        
        #if DEBUG
        print("------------發現服務------------")
        print("\(peripheral.services!)")
        #endif
        
        guard let services = peripheral.services else { return }
        
        for service in services {
            #if DEBUG
            print("*************每個服務*************")
            print(service)
            #endif
            peripheral.discoverCharacteristics(nil, for: service)
        }
        
    }
    
    // MARK: - BLE 發現 Characteristics 的處理函數
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        delegate?.HandlePeripheral(peripheral, didDiscoverCharacteristicsFor: service, error: error)
        
        for characteristic in service.characteristics! {

            if characteristic.properties.contains(.read) {
                #if DEBUG
                print("\(characteristic.uuid):read mode")  // 找到 read 方式的 characteristics 並讀取
                #endif
            }
            
            if characteristic.properties.contains(.notify) {
                #if DEBUG
                print("\(characteristic.uuid):notify mode")  // 找到 notify 方式的 characteristics 並讀取
                #endif
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            if characteristic.properties.contains(.indicate) {
                print("\(characteristic.uuid):indicate mode")
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            if characteristic.uuid == b_2aa8 {
                transmitterInfo?.SensorState = 0
                peripheral.readValue(for: characteristic)
            } else if characteristic.uuid == uuid2 {
                queryCharacteristic = characteristic
            } else if characteristic.uuid == uuid3 {
                coverCharacteristic = characteristic
            } else if characteristic.uuid == uuid4 {
                adcCharacteristic = characteristic
            } else if characteristic.uuid == uuid5 {
                utcInfoCharacteristic = characteristic
            } else if characteristic.uuid == b_2aa7 {
                measurementCharacteristic = characteristic
            } else if characteristic.uuid == b_2aa9 {
                statusCharacteristic = characteristic
            } else if characteristic.uuid == b_2aaa {
                sessionStartTimeCharacteristic = characteristic
            } else if characteristic.uuid == b_2aab {
                sessionRunTimeCharacteristic = characteristic
            } else if characteristic.uuid == b_2a52 {
                accessControlCharacteristic = characteristic
            } else if characteristic.uuid == b_2cca {
                specificOpsControl = characteristic
            }
            
        }
        
    }
    
    // MARK: - BLE Characteristics 值 Read/notify 的處理函數
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        switch characteristic.uuid {
        case b_2aa8:
            print("-----------------------2AA8------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.deviceInfoDataChange(arrayData)
            guard let major = commandBase.deviceInfoData?.major?.strHex2Int() else { return }
            guard let minor = commandBase.deviceInfoData?.minor?.strHex2Int() else { return }
            guard let debug = commandBase.deviceInfoData?.debug?.strHex2Int() else { return }
            guard let type = commandBase.deviceInfoData?.type?.strHex2Int() else { return }
            guard let sample_location = commandBase.deviceInfoData?.sample_location?.strHex2Int() else { return }
            guard let sleepTime = commandBase.deviceInfoData?.sleepTime?.strHex2Int() else { return }
            guard let preConditionTime = commandBase.deviceInfoData?.preConditionTime?.strHex2Int() else { return }
            guard let advTime = commandBase.deviceInfoData?.advTime?.strHex2Int() else { return }
            guard let dacTime = commandBase.deviceInfoData?.dacTime?.strHex2Int() else { return }
            print("2AA8 Parse Data:", major, minor , debug, type, sample_location, sleepTime, preConditionTime, advTime, dacTime )
            transmitterInfo?.FWVersion = "\(major)."+"\(minor)."+"\(debug)"
            transmitterInfo?.SensorType = type
            transmitterInfo?.SensorLocation = sample_location
            SDK_Setting.shared.fwVersion = "\(major)."+"\(minor)."+"\(debug)"
            peripheral.readValue(for: utcInfoCharacteristic)    // Read FFF5
            
        case uuid5:
            print("-----------------------FFF5------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.rtcInfoChange(arrayData)
            guard let dStartTime = commandBase.deviceRtcInfoData?.dStartTime?.strHex2Int() else { return }
            guard let dRtcTime = commandBase.deviceRtcInfoData?.dRtcTime?.strHex2Int() else { return }
            guard let dRtcIndex = commandBase.deviceRtcInfoData?.dRtcIndex?.strHex2Int() else { return }
            print("\(characteristic.uuid):StartTime:\(dStartTime), RtcTime:\(dRtcTime), RtcIndex:\(dRtcIndex)")
            transmitterInfo?.TransmitterTime = dStartTime
            let finishStamp = dStartTime + 365 * 24 * 60 * 60
            transmitterInfo?.TransmitterTotalLife = finishStamp - Int(Date().timeIntervalSince1970)
            peripheral.readValue(for: statusCharacteristic)    // Read 2AA9
            
        case b_2aa9:
            print("-----------------------2AA9------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.statusDataChange(arrayData)
            guard let size = commandBase.statusData?.size?.strHex2Int() else { return }
            guard let timeOffset = commandBase.statusData?.timeOffset?.strHex2Int() else { return }
            guard let cgmStatus = commandBase.statusData?.cgmStatus?.strHex2Int() else { return }
            guard let e2e_crc = commandBase.statusData?.e2e_crc?.strHex2Int() else { return }
            guard let warmUpTime = commandBase.statusData?.warmUpTime?.strHex2Int() else { return }
            guard let calibrationTime = commandBase.statusData?.calibrationTime?.strHex2Int() else { return }
            transmitterInfo?.SensorState = cgmStatus
            transmitterInfo?.Remain_warmUp_time = warmUpTime
            transmitterInfo?.Remain_calibration_time = calibrationTime
            
            SDK_Setting.shared.warmUpTime = warmUpTime * 60

            // 暫時
            if calibrationTime != 0 {
                SDK_Setting.shared.nextCalibrateInterval = Int64(calibrationTime * 60 * 1000) + (Date().millisecondsSince1970 - SDK_Setting.shared.finishCalibrateTimeStamp)
            }

            if warmUpTime <= 0 {
                SDK_Setting.shared.isWarmUpBool = false
                transmitterInfo?.TransmitterState = 3
            } else {
                SDK_Setting.shared.isWarmUpBool = true
                SDK_Setting.shared.isFirstCalibration = true
                transmitterInfo?.TransmitterState = 2
            }

            if (SDK_Setting.shared.finishCalibrateTimeStamp + SDK_Setting.shared.nextCalibrateInterval) < Date().millisecondsSince1970 {
                SDK_Setting.shared.isCalibrated = false
            } else {
                SDK_Setting.shared.isCalibrated = true
            }
            currentRecordInfo?.isDisplay = SDK_Setting.shared.isCalibrated
            
            SDK_Setting.shared.finishWarmUpTimeStamp = Date().millisecondsSince1970 + Int64(warmUpTime * 60 * 1000)

            peripheral.readValue(for: sessionStartTimeCharacteristic)   // Read 2AAA
            
        case b_2aaa:
            print("-----------------------2AAA------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.sessionStartTimeDataChange(arrayData)
            guard let size = commandBase.sessionStartTime?.size?.strHex2Int() else { return }
            guard let startTime = commandBase.sessionStartTime?.startTime else { return }
            guard let timeZone = commandBase.sessionStartTime?.timeZone?.strHex2Int() else { return }
            guard let dst = commandBase.sessionStartTime?.dst?.strHex2Int() else { return }
            guard let e2e_crc = commandBase.sessionStartTime?.e2e_crc?.strHex2Int() else { return }
            
            if startTime == "00000000000000" {
//                SDK_Setting.shared.isSensorOverride = false
                print("啟用感測器")
                sensorStart(targetPeripheral: peripheral, startDate: Date())
            } else {
                SDK_Setting.shared.isSensorOverride = true
                
                let year = startTime.substring(with: 0..<4).strHex2Int().description.strAddZero(count: 4)
                let month = startTime.substring(with: 4..<6).strHex2Int().description.strAddZero(count: 2)
                let day = startTime.substring(with: 6..<8).strHex2Int().description.strAddZero(count: 2)
                let hour = startTime.substring(with: 8..<10).strHex2Int().description.strAddZero(count: 2)
                let min = startTime.substring(with: 10..<12).strHex2Int().description.strAddZero(count: 2)
                let sec = startTime.substring(with: 12..<14).strHex2Int().description.strAddZero(count: 2)
                let timeStr = "\(day)/\(month)/\(year)T\(hour):\(min):\(sec)"
                let timeDate = timeStr.str2Date()

                SDK_Setting.shared.sensorDate = timeDate.convert2UtcStr()
                SDK_Setting.shared.sensorBindingTimeStamp = Int64(timeDate.timeIntervalSince1970)
            }
            
            peripheral.readValue(for: sessionRunTimeCharacteristic)   // Read 2AAB
            
        case b_2aab:
            print("-----------------------2AAB------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.sessionRunTimeDataChange(arrayData)
            guard let size = commandBase.sessionRunTime?.size?.strHex2Int() else { return }
            guard let runTime = commandBase.sessionRunTime?.runTime?.strHex2Int() else { return }
            guard let e2e_crc = commandBase.sessionRunTime?.e2e_crc?.strHex2Int() else { return }
            
            // 如果 sensorID 尚未寫入，需寫入
            if SDK_Setting.shared.isSensorOverride == false {
                sensorIdWrite(targetPeripheral: peripheral)
            }
            // 如果尚未完成校正，需校正
            if SDK_Setting.shared.calibrateValue != -1 && SDK_Setting.shared.isCgmCanWriteCalibrate == true {
                calibrateWrite(calibrateValue: SDK_Setting.shared.calibrateValue, targetPeripheral: peripheral)
            }
            
            peripheral.readValue(for: adcCharacteristic)   // Read FFF4
            
        case uuid4:
            print("-----------------------FFF4------------------------")
            var deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            print("\(Date().description(with: Locale.current))")
            deviceData = "534b0215\(deviceData ?? "")c5"
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.advertiDataChange(arrayData)
            guard let adc2Int = commandBase.advData?.adc?.strHex2Int() else{ return }
            guard let temp2Int = commandBase.advData?.temperature?.strHex2Int() else { return }
            guard let battery2Int = commandBase.advData?.battery?.strHex2Int() else { return }
            battery = battery2Int
            guard let macAddr2 = commandBase.advData?.macAddr else { return }
            guard let count = commandBase.advData?.count else { return }
            let recordCountInt = count.strHex2Int()
            guard let dataRtcTime = commandBase.advData?.rtcTime?.strHex2Int() else { return }
            guard let resetCount = commandBase.advData?.resetCount?.strHex2Int() else { return }
            guard let chargeCount = commandBase.advData?.chargeCount?.strHex2Int() else { return }
            guard let trend = commandBase.advData?.trend?.strHex2Int() else { return }
            
            transmitterInfo?.BatteryLevel = battery2Int
            transmitterInfo?.MacAddr = macAddr2
            transmitterInfo?.ResetCount = resetCount
            transmitterInfo?.ChargeCount = chargeCount
            
            currentRecordInfo?.Timestamp = Int64(dataRtcTime)
            currentRecordInfo?.IndexID = recordCountInt
            currentRecordInfo?.RawData = [adc2Int]
            currentRecordInfo?.CalibrationData = [adc2Int]
            currentRecordInfo?.Temperature = temp2Int
            currentRecordInfo?.Trend = trend
            currentRecordInfo?.SensorID = SDK_Setting.shared.sensorID
            currentRecordInfo?.UserID = SDK_Setting.shared.username
            currentRecordInfo?.Battery = battery2Int
            
            if transmitterInfo?.TransmitterTime == 0 {
                // 裝置第一次啟用
                SDK_Setting.shared.firstRecordCount = count
                SDK_Setting.shared.lastRecordCount = count
                SDK_Setting.shared.isWarmUpTimeStamp = Date().millisecondsSince1970
                SDK_Setting.shared.isWarmUpBool = true
                SDK_Setting.shared.nextCalibrateInterval = 0
                SDK_Setting.shared.isCalibrated = false
                SDK_Setting.shared.resetCount = resetCount
//                LocalDatabase.shared.saveRecordCountData()
                let timestamp = Int(NSDate().timeIntervalSince1970)
                let timeZoneInt = TimeZone.autoupdatingCurrent.secondsFromGMT() / 3600
                SDK_Setting.shared.lastTimeZoneNumber = timeZoneInt
                print("lastTimeZoneNumber:\(SDK_Setting.shared.lastTimeZoneNumber)")
                let UtcData = timestamp.int2StrHex8() + timestamp.int2StrHex8() + count
                writeUtcData(data: UtcData, targetPeripheral: peripheral)
            } else {
                // 裝置非第一次啟用
                
                // 裝置reset
                if (SDK_Setting.shared.resetCount == 0) || SDK_Setting.shared.resetCount != resetCount {
                    print("成立條件1 Reset==0:\(SDK_Setting.shared.resetCount == 0),成立條件2 Reset變更:\(SDK_Setting.shared.resetCount != resetCount)")
                    print("裝置非第一次啟用, 當前 Index: \(count.strHex2Int())")
                    SDK_Setting.shared.lastRecordCount = count
                    SDK_Setting.shared.resetCount = resetCount
                    if SDK_Setting.shared.firstRecordCount == "00000000" {
                        print("變更FirstRccordCount")
                        SDK_Setting.shared.firstRecordCount = count
                    }
//                    LocalDatabase.shared.saveRecordCountData()
                    let timestamp = Int(NSDate().timeIntervalSince1970)
                    let UtcData = 0.int2StrHex8() + timestamp.int2StrHex8() + count
                    SDK_Setting.shared.nextCalibrateInterval = 0
                    SDK_Setting.shared.isCalibrated = false
                    writeUtcData(data: UtcData, targetPeripheral: peripheral)
                } else {
                    // 原先判斷是否回補的地方
                    // 事件回傳
                    delegate?.EventCallback(eventID: 2, value: 0)
                }
            }
            
        case b_2a52:
            print("-----------------------2A52------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            
        case b_2cca:
            print("-----------------------2CCA------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.opsControlPointChange(arrayData)
            guard let size = commandBase.opsControlPoint?.size?.strHex2Int() else { return }
            guard let opCode = commandBase.opsControlPoint?.opCode?.strHex2Int() else { return }
            guard let reqOPCode = commandBase.opsControlPoint?.reqOPCode?.strHex2Int() else { return }
            guard let rspCode = commandBase.opsControlPoint?.rspCode?.strHex2Int() else { return }
            print(size, opCode, reqOPCode, rspCode)
            
            // sensorID 設定完成
            if reqOPCode == 29 {
                SDK_Setting.shared.isSensorOverride = true
                
                // 成功 value = 0, 失敗 value = 1
                delegate?.EventCallback(eventID: 4, value: rspCode == 1 ? 0 : 1)
            }
            // 血糖校正完成
            if reqOPCode == 4 {
                SDK_Setting.shared.calibrateValue = -1
                
                // 成功 value = 0, 失敗 value = 1
                delegate?.EventCallback(eventID: 5, value: rspCode == 1 ? 0 : 1)
            }
        case uuid3:
            print("-----------------------FFF3------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.coverDataChange(arrayData)
            guard let startIndex = commandBase.coverData?.startIndex?.strHex2Int() else { return }
            guard let totalCount = commandBase.coverData?.totalCount?.strHex2Int() else { return }
            guard let adc = commandBase.coverData?.adc?.strHexArray2IntArray() else { return }
            guard let temp = commandBase.coverData?.temperature?.strHexArray2IntArray() else { return }
            guard let rtcTime = commandBase.coverData?.rtcTime?.strHexArray2IntArray() else { return }
            
            // 最後一筆回補index
            let lastCoverIndex = startIndex + totalCount - 1
            print("欲回補array", coverIdArray)
            print("回補 startIndex: \(startIndex), endIndex:\(lastCoverIndex) , totalCount: \(totalCount)")

            // 製作回補資料
            for index in 0 ..< totalCount {
                let coverInfo = SensingRecord()
                coverInfo.Timestamp = Int64(rtcTime[index])
                coverInfo.IndexID = startIndex + index
                coverInfo.RawData = [adc[index]]
                coverInfo.CalibrationData = [adc[index]]
                coverInfo.Temperature = temp[index]
                coverInfo.Trend = 0
                coverInfo.SensorID = SDK_Setting.shared.sensorID
                coverInfo.UserID = SDK_Setting.shared.username
                coverInfo.isDisplay = SDK_Setting.shared.isCalibrated
                coverInfo.Battery = battery
                oldRecordInfo?.append(coverInfo)
            }

            // 判斷是否需要繼續回補
            if lastCoverIndex >= coverIdArray.last! {
                // 回補結束
                
                // ***********過濾不需回傳的資料***********
                var deleteArray = [Int]()
                for recordInfoIndex in 0 ..< oldRecordInfo!.count {
                    var isExsit = false
                    for coverInfo in coverIdArray {
                        if oldRecordInfo![recordInfoIndex].IndexID! == coverInfo{
                            isExsit = true
                            break
                        }
                    }
                    if !isExsit {
                        deleteArray.append(recordInfoIndex)
                    }
                }
                oldRecordInfo?.removeSpecifiedIndices(deleteArray)
                oldRecordInfo?.sort { $0.IndexID! < $1.IndexID! }
                // ************************************
                
                
                // callBack
                delegate?.EventCallback(eventID: 3, value: oldRecordInfo!.count)
                
            } else {
                // 繼續回補
                setQueryCoverCount(startIndex: lastCoverIndex + 1)
            }
            
        case b_2aa7:
            print("-----------------------2AA7------------------------")
            let deviceData = characteristic.value?.hexEncodedString()
            print("\(characteristic.uuid):\(deviceData ?? "empty")")
            guard let arrayData = deviceData?.separatedData(step: 2) else{ return }
            commandBase.measurementDataChange(arrayData)
            guard let size = commandBase.measurementData?.size?.strHex2Int() else { return }
            guard let flag = commandBase.measurementData?.flag?.strHex2Int() else { return }
            guard let glucose = commandBase.measurementData?.glucose?.strHex2Int() else { return }
            guard let timeoffset = commandBase.measurementData?.timeoffset?.strHex2Int() else { return }
            guard let status = commandBase.measurementData?.status?.strHex2Int() else { return }
            guard let trend = commandBase.measurementData?.trend?.strHex2Int() else { return }
            guard let quality = commandBase.measurementData?.quality?.strHex2Int() else { return }
            guard let e2e_crc = commandBase.measurementData?.e2e_crc?.strHex2Int() else { return }
            print(size, flag, glucose, timeoffset, status, trend, quality, e2e_crc)
            
        default:
            print(characteristic.uuid)
        }
        
        // 回傳事件
        delegate?.HandlePeripheral(peripheral, didUpdateValueFor: characteristic, error: error)
        
        // 如果 transmitter 資料搜集完成
        transmitterInfo?.TransmitterID = SDK_Setting.shared.deviceID
        transmitterInfo?.UserID = SDK_Setting.shared.username

        // 準備資料，檢查 Transmitter 資料是否準備完成，準備完成，就會打 callback 通知使用者可以來拿資料
        if transmitterInfo?.checkVariableIsReady() == true {
            sensorInfo?.SensorID = SDK_Setting.shared.sensorID
            sensorInfo?.TransmitterID = SDK_Setting.shared.deviceID
            sensorInfo?.UserID = SDK_Setting.shared.username
            sensorInfo?.SensorStartTime = Int(SDK_Setting.shared.sensorBindingTimeStamp)
            
            if sensorInfo?.SensorStartTime != nil {
                let finishStamp = (sensorInfo?.SensorStartTime)! + 7 * 24 * 60 * 60
                sensorInfo?.SensorTotalLife = finishStamp - Int(Date().timeIntervalSince1970)
            }
            
            delegate?.EventCallback(eventID: 1, value: 0)
            
            delegate?.EventCallback(eventID: 6, value: (transmitterInfo?.SensorState)!)
        }
        
    }
    
    /// 說明: BLE Characteristics 值 write 的處理函數
    public func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        delegate?.HandlePeripheral(peripheral, didWriteValueFor: characteristic, error: error)
    }
}

// MARK: - 外部呼叫用func
public extension SDK_BluetoothService {
    /// 說明: 讀取藍芽資訊取得 TransmitterInfo，收到EventCallback 時呼叫。
    public func getTransmitterInfo() -> TransmitterInfo? {
        return transmitterInfo
    }
    
    /// 說明: 讀取藍芽資訊取得最新一筆 SensingRecord，收到EventCallback 時呼叫。
    public func getSensingRecordInfo() -> SensingRecord? {
        return currentRecordInfo
    }
    
    /// 說明: 讀取藍芽資訊取得過去的 SensingRecord，收到EventCallback 時呼叫。
    public func getSyncRecords() -> [SensingRecord]? {
        return oldRecordInfo
    }
    
    /// 說明: 設定需要進行資料回補的資料序號。
    public func setSyncRecordIndex(idxArray: [Int]) {
//        syncCoverBool = true
        coverIdArray = idxArray.sorted{ $0 < $1}
        setQueryCoverCount(startIndex: coverIdArray.first!)
    }
    
    /// 說明: 設定 SensorID 到傳輸器。// 實際寫入的時間須等待到藍芽連線時啟動，並透過Callback通知是否完成。
    public func setSensorID(sensorID: String) {
        SDK_Setting.shared.sensorID = sensorID
        SDK_Setting.shared.isSensorOverride = false
    }
    
    /// 說明: 設定 Sensor 啟用時間。// 實際寫入的時間須等待到藍芽連線時啟動，並透過Callback通知是否完成。
    /// - Parameters:
    ///   - currentTime: bool 是否使用連線到裝置時的當前時間，true的話第二個參數設定為 Null，false的話用第二個參數的時間設定。
    ///   - config: time
    public func setSensorStartTime(currentTime: Bool, config: Date?) {
        if currentTime == false && config == nil { return }
        var startDate = Date()
        if currentTime == false {
            startDate = config!
        }
        sensorStart(targetPeripheral: blePeripheral, startDate: startDate)
    }
    
    /// 說明: 設定校正血糖到傳輸器。// 實際寫入的時間須等待到藍芽連線時啟動，並透過Callback通知是否完成。
    /// - Parameter calibration: 寫入的血糖值(mg/dL)
    public func setCalibration(calibration: Int) {
        SDK_Setting.shared.calibrateValue = calibration
    }
     
}

// MARK: - SDK 內部用 func
extension SDK_BluetoothService {
    /// 寫入 FFF5 時間
    private func writeUtcData(data:String, targetPeripheral: CBPeripheral) {
        print("WriteUtcData:\(data)")
        let target = Data(hex: data)
        targetPeripheral.writeValue(target, for: utcInfoCharacteristic, type: .withResponse)
    }
    
    /// sensor 啟用
    private func sensorStart(targetPeripheral: CBPeripheral, startDate: Date) {
        SDK_Setting.shared.sensorDate = startDate.convert2UtcStr()
        SDK_Setting.shared.sensorBindingTimeStamp = Int64(startDate.timeIntervalSince1970)
        let date = startDate.convert2LocalHex()
        print("啟用感測器： \(date)")
        let timeZoneInt = TimeZone.autoupdatingCurrent.secondsFromGMT() / 3600
        let data = "0C" + date + timeZoneInt.int2StrHex2() + "00" + "0000"
        let target = Data(hex: data)
        targetPeripheral.writeValue(target, for: sessionStartTimeCharacteristic, type: .withResponse)
    }
    
    /// FFF2 要求資料回補
    private func queryData(count:String, targetPeripheral: CBPeripheral) {
        let target = Data(hex: count)
        print("要求CoverStr:\(count)")
        targetPeripheral.writeValue(target, for: queryCharacteristic, type: .withResponse)
    }
    
    /// 讀取資料
    private func readData(targetPeripheral: CBPeripheral) {
        targetPeripheral.readValue(for: coverCharacteristic)
    }
    
    /// 血糖校正值寫入
    private func calibrateWrite(calibrateValue: Int, targetPeripheral: CBPeripheral) {
        let data = "050402" + calibrateValue.int2StrHex4()
        let target = Data(hex: data)
        targetPeripheral.writeValue(target, for: specificOpsControl, type: .withResponse)
    }
    
    /// sensorID 寫入
    private func sensorIdWrite(targetPeripheral: CBPeripheral) {
        // let data = "071D04" + SDK_Setting.shared.sensorID.stringValue2HexString(byte: 4)
        let sensor = SDK_Setting.shared.sensorID
        guard sensor.count >= 6 else { return }
        let index = sensor.index(sensor.endIndex, offsetBy: -6)
        let sensorID = sensor.substring(from: index)
        let data = "071D04" + "00" + sensorID
        let target = Data(hex: data)
        targetPeripheral.writeValue(target, for: specificOpsControl, type: .withResponse)
    }
    
    /// 執行一次回補 (一次最多回補 10 筆)
    private func setQueryCoverCount(startIndex: Int) {
        let totalCount = coverIdArray.last! - startIndex + 1
        
        //檢查欲回補資料筆數
        if totalCount > 10 {
            // 大於 10 筆，需分次回補
            singleCover = singleCoverStruct(index: startIndex, count: 10)
        } else {
            // 小於等於 10 筆，直接回補
            singleCover = singleCoverStruct(index: startIndex, count: totalCount)
        }
        
        // 開始第一次回補
        let startIndexStr = singleCover.index?.int2StrHex8()
        let coverDataStr = startIndexStr! + singleCover.count!.int2StrHex4()
        queryData(count: coverDataStr, targetPeripheral: blePeripheral)
    }
}
