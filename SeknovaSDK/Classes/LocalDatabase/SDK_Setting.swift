//
//  SDK_Setting.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/4/25.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class SDK_Setting {
    
    public static let shared = SDK_Setting()
    
    private let userPreferences: UserDefaults
    
    private init() { userPreferences = UserDefaults.standard }
    
    public enum UserPreference: String {
        case defaultADC                 // 顯示時 預設的血糖值
        case username                   // 帳號
        case password                   // 密碼
        case deviceID                   // Transmiter ID
        case sensorID                   // Sensor ID
        case sensorDate                 // Sensor 啟用時間
        case sensorBindingTimeStamp     // Sensor 啟用時間
        case lastRecordCount            // 最後一筆 收到的血糖 index
        case firstRecordCount           // 第一筆 收到的血糖 index
        case isWarmUpBool               // 裝置是否正在暖機
        case isWarmUpTimeStamp          // 裝置開始暖機的時間
        case finishWarmUpTimeStamp      // 裝置預計完成暖機的時間
        case fwVersion                  // 韌體版本
        case isCalibrated               // 是否完成校正
        case calibrateValue             // 欲校正的數值
        case lastTimeZoneNumber         // 時區
        case resetCount                 // 裝置reset次數
        case isFirstLogin               // 是否為首次登入
        case isSensorOverride           // 紀錄 Sensor ID 是否已寫入成功
        case isCgmCanWriteCalibrate     // 紀錄 cgmStatus 回傳的 byte[10]，是否有禁用血糖校正功能
        case warmUpTime                 // 暖機剩餘時間
        case isFirstCalibration         // 是否為第一次校正
        case finishCalibrateTimeStamp   // 最後一筆完成校正時間
        case nextCalibrateInterval      // 下次預計校正時間
        
        //----血糖校正參數----
        case RawData2BGBias
        case BGBias
        case BGLow
        case BGHigh
        case MapRate
        case ThresholdRise
        case ThresholdFall
        case RiseRate
        case FallenRate
        //-------------------
    }
    
    public var isFirstCalibration: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isFirstCalibration.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isFirstCalibration.rawValue) }
    }
    public var warmUpTime: Int {
        get { return userPreferences.integer(forKey: UserPreference.warmUpTime.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.warmUpTime.rawValue) }
    }
    public var defaultADC: String {
        get { return userPreferences.string(forKey: UserPreference.defaultADC.rawValue) ?? "0"}
        set { userPreferences.set(newValue, forKey: UserPreference.defaultADC.rawValue) }
    }
    public var isCgmCanWriteCalibrate: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isCgmCanWriteCalibrate.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isCgmCanWriteCalibrate.rawValue) }
    }
    public var isSensorOverride: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isSensorOverride.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isSensorOverride.rawValue) }
    }
    public var username: String {
        get { return userPreferences.string(forKey: UserPreference.username.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.username.rawValue) }
    }
    public var password: String {
        get { return userPreferences.string(forKey: UserPreference.password.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.password.rawValue) }
    }
    public var deviceID: String {
        get { return userPreferences.string(forKey: UserPreference.deviceID.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.deviceID.rawValue) }
    }
    public var sensorID: String {
        get { return userPreferences.string(forKey: UserPreference.sensorID.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.sensorID.rawValue) }
    }
    public var sensorDate: String {
        get { return userPreferences.string(forKey: UserPreference.sensorDate.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.sensorDate.rawValue) }
    }
    public var sensorBindingTimeStamp: Int64 {
        get { return Int64(userPreferences.integer(forKey: UserPreference.sensorBindingTimeStamp.rawValue)) }
        set { userPreferences.set(newValue, forKey: UserPreference.sensorBindingTimeStamp.rawValue) }
    }
    public var lastRecordCount: String {
        get { return userPreferences.string(forKey: UserPreference.lastRecordCount.rawValue) ?? "00000000"}
        set { userPreferences.set(newValue, forKey: UserPreference.lastRecordCount.rawValue) }
    }
    public var firstRecordCount: String {
        get { return userPreferences.string(forKey: UserPreference.firstRecordCount.rawValue) ?? "00000000"}
        set { userPreferences.set(newValue, forKey: UserPreference.firstRecordCount.rawValue) }
    }
    public var isWarmUpBool: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isWarmUpBool.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isWarmUpBool.rawValue) }
    }
    public var isWarmUpTimeStamp: Int64 {
        get { return Int64(userPreferences.integer(forKey: UserPreference.isWarmUpTimeStamp.rawValue)) }
        set { userPreferences.set(newValue, forKey: UserPreference.isWarmUpTimeStamp.rawValue) }
    }
    public var finishWarmUpTimeStamp: Int64 {
        get { return Int64(userPreferences.integer(forKey: UserPreference.finishWarmUpTimeStamp.rawValue)) }
        set { userPreferences.set(newValue, forKey: UserPreference.finishWarmUpTimeStamp.rawValue) }
    }
    public var fwVersion: String {
        get { return userPreferences.string(forKey: UserPreference.fwVersion.rawValue) ?? ""}
        set { userPreferences.set(newValue, forKey: UserPreference.fwVersion.rawValue) }
    }
    public var isCalibrated: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isCalibrated.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isCalibrated.rawValue) }
    }
    public var finishCalibrateTimeStamp: Int64 {
        get { return Int64(userPreferences.integer(forKey: UserPreference.finishCalibrateTimeStamp.rawValue)) }
        set { userPreferences.set(newValue, forKey: UserPreference.finishCalibrateTimeStamp.rawValue) }
    }
    public var nextCalibrateInterval: Int64 {
        get { return Int64(userPreferences.integer(forKey: UserPreference.nextCalibrateInterval.rawValue)) }
        set { userPreferences.set(newValue, forKey: UserPreference.nextCalibrateInterval.rawValue) }
    }
    public var calibrateValue : Int {
        get { return userPreferences.integer(forKey: UserPreference.calibrateValue.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.calibrateValue.rawValue) }
    }
    public var lastTimeZoneNumber : Int {
        get { return userPreferences.integer(forKey: UserPreference.lastTimeZoneNumber.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.lastTimeZoneNumber.rawValue) }
    }
    public var resetCount: Int {
        get { return userPreferences.integer(forKey: UserPreference.resetCount.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.resetCount.rawValue) }
    }
    public var isFirstLogin: Bool {
        get { return userPreferences.bool(forKey: UserPreference.isFirstLogin.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.isFirstLogin.rawValue) }
    }
    public var RawData2BGBias: Int {
        get { return userPreferences.integer(forKey: UserPreference.RawData2BGBias.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.RawData2BGBias.rawValue) }
    }
    public var BGBias: Int {
        get { return userPreferences.integer(forKey: UserPreference.BGBias.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.BGBias.rawValue) }
    }
    public var BGLow: Int {
        get { return userPreferences.integer(forKey: UserPreference.BGLow.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.BGLow.rawValue) }
    }
    public var BGHigh: Int {
        get { return userPreferences.integer(forKey: UserPreference.BGHigh.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.BGHigh.rawValue) }
    }
    public var MapRate: Int {
        get { return userPreferences.integer(forKey: UserPreference.MapRate.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.MapRate.rawValue) }
    }
    public var ThresholdRise: Int {
        get { return userPreferences.integer(forKey: UserPreference.ThresholdRise.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.ThresholdRise.rawValue) }
    }
    public var ThresholdFall: Int {
        get { return userPreferences.integer(forKey: UserPreference.ThresholdFall.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.ThresholdFall.rawValue) }
    }
    public var RiseRate: Int {
        get { return userPreferences.integer(forKey: UserPreference.RiseRate.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.RiseRate.rawValue) }
    }
    public var FallenRate: Int {
        get { return userPreferences.integer(forKey: UserPreference.FallenRate.rawValue) }
        set { userPreferences.set(newValue, forKey: UserPreference.FallenRate.rawValue) }
    }
}
