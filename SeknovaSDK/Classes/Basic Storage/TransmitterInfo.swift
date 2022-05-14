//
//  TransmitterInfo.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/3/23.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class TransmitterInfo: NSObject {
    
    public var TransmitterID: String?
    public var UserID: String?
    public var TransmitterTime: Int?
    public var TransmitterTotalLife: Int?
    public var BatteryLevel: Int?
    public var FWVersion: String?
    public var MacAddr: String?
    public var ResetCount: Int?
    public var ChargeCount: Int?
    public var TransmitterState: Int?
    public var SensorState: Int?
    public var SensorType: Int?
    public var SensorLocation: Int?
    public var Remain_warmUp_time: Int?
    public var Remain_calibration_time: Int?
    
    public func checkVariableIsReady() -> Bool {
        var isReady = true
        if TransmitterID == nil { isReady = false }
        if UserID == nil { isReady = false }
        if TransmitterTime == nil { isReady = false }
        if TransmitterTotalLife == nil { isReady = false }
        if BatteryLevel == nil { isReady = false }
        if FWVersion == nil { isReady = false }
        if MacAddr == nil { isReady = false }
        if ResetCount == nil { isReady = false }
        if ChargeCount == nil { isReady = false }
        if TransmitterState == nil { isReady = false }
        if SensorState == nil { isReady = false }
        if SensorType == nil { isReady = false }
        if SensorLocation == nil { isReady = false }
        if Remain_warmUp_time == nil { isReady = false }
        if Remain_calibration_time == nil { isReady = false }
        return isReady
    }
    
    public func GetUsedTime() -> Int {
        if TransmitterTime == nil {
            return 0
        } else {
            return Int(Date().timeIntervalSince1970) - TransmitterTime!
        }
    }
    
}
