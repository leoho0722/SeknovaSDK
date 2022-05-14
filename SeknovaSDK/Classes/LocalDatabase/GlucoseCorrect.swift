//
//  CalibrationMapping.swift
//  Seknova
//
//  Created by imac on 2021/12/14.
//  Copyright © 2021 鈞. All rights reserved.
//

import Foundation
import RealmSwift

public class DataCorrectionAlgo: NSObject {
    
    public static let share = DataCorrectionAlgo()
    
    // DataCorrectionAlgo 的 update 不是存本地 DB，而是存在本地，像是 UserDefaults
    // LocalDatabaseManager 那邊的 Update 就是存在本地 DB，
    public func GlucoseCorrect(records: [SensingRecord]) -> SensingRecord {
        
        // MARK: - 取得校正規則
//        let realm = try! Realm()
//        let results = realm.objects(CalibrationMode.self)
//        let calibrationRule = results[0]
//        print(calibrationRule)
        let RawData2BGBias: Int = SDK_Setting.shared.RawData2BGBias
        let BGBias: Int = SDK_Setting.shared.BGBias
        let BGLow: Int = SDK_Setting.shared.BGLow
        let BGHigh: Int = SDK_Setting.shared.BGHigh
        let MapRate = SDK_Setting.shared.MapRate
        let ThresholdRise = SDK_Setting.shared.ThresholdRise
        let ThresholdFall = SDK_Setting.shared.ThresholdFall
        let RiseRate = SDK_Setting.shared.RiseRate
        let FallenRate = SDK_Setting.shared.FallenRate
        
        // MARK: - 取得 data 陣列
        var localDataArray: [SensingRecord] = records
        localDataArray.reverse()
        
        localDataArray[0].CalibrationData = [0]
        
        // MARK: - Method 1_Moving Average
        let finalValue = method_1(dataArray: localDataArray)
        
        // MARK: - Method 2_Value Mapping
        let smoothedValue = method_2(rawData: finalValue, rawDataMappingBG_Bias: RawData2BGBias, bgBias: BGBias, mappingRate: MapRate, bgLow: BGLow, bgHigh: BGHigh)
        localDataArray[0].CalibrationData![0] = Int(smoothedValue)
        
        // MARK: - Method 3_Trend Protect 1/2
        localDataArray = method_3_1(dataArray: localDataArray, threshold_Rise: ThresholdRise, threshold_Fallen: ThresholdFall)
        
        // MARK: - Method 3_Trend Protect 2/2
        return method_3_2(dataArray: localDataArray, riseRate: RiseRate, fallenRate: FallenRate)
        
    }
    
    /// Method 1_Moving Average
    private func method_1(dataArray: [SensingRecord]) -> Double {
        
        var ans: Double = 0
        
        for data in dataArray {
            ans += Double((data.RawData?.first)!)
        }
        
        return ans / Double(dataArray.count)
    }
    
    /// Method 2_Value Mapping
    private func method_2(rawData: Double, rawDataMappingBG_Bias: Int, bgBias: Int, mappingRate: Int, bgLow: Int, bgHigh: Int) -> Double {
        
        let ans: Double = ((rawData - Double(rawDataMappingBG_Bias)) / Double(mappingRate)) + Double(bgBias)
        
        if ans > Double(bgHigh) {
            return Double(bgHigh)
        } else if ans < Double(bgLow) {
            return Double(bgLow)
        } else {
            return ans
        }
    }
    
    /// - Method 3_Trend Protect 1/2
    private func method_3_1(dataArray: [SensingRecord], threshold_Rise: Int, threshold_Fallen: Int) -> [SensingRecord] {
        
        let newDataArray = dataArray
        
        guard newDataArray.count > 2 else {
            return newDataArray
        }
        
        if newDataArray[0].CalibrationData![0] - newDataArray[1].CalibrationData![0] > 0 {
            let Tr = (newDataArray[0].CalibrationData![0]) - (newDataArray[1].CalibrationData![0])
            if Tr > threshold_Rise{
                newDataArray[0].CalibrationData![0] = newDataArray[1].CalibrationData![0] + threshold_Rise
            }
        } else if newDataArray[0].CalibrationData![0] - newDataArray[1].CalibrationData![0] < 0 {
            let Tf = (newDataArray[1].CalibrationData![0]) - (newDataArray[0].CalibrationData![0])
            if Tf > threshold_Fallen {
                newDataArray[0].CalibrationData![0] = newDataArray[1].CalibrationData![0] - threshold_Fallen
            }
        }
        
        return newDataArray
        
    }
    
    /// - Method 3_Trend Protect 2/2
    private func method_3_2(dataArray: [SensingRecord], riseRate: Int, fallenRate: Int) -> SensingRecord {
        
        var newDataArray = dataArray
        
        guard newDataArray.count > 2 else {
            return newDataArray[0]
        }
        
        var min = newDataArray[0].CalibrationData![0]
        
        var max = newDataArray[0].CalibrationData![0]
        
        for data in newDataArray {
            min = data.CalibrationData![0] < min ? data.CalibrationData![0] : min
            max = data.CalibrationData![0] > max ? data.CalibrationData![0] : max
        }
        
        if newDataArray[0].CalibrationData![0] - newDataArray[1].CalibrationData![0] > 0 {
            let Tr = newDataArray[0].CalibrationData![0] - min
            if Tr > riseRate{
                newDataArray[0].CalibrationData![0] = min + riseRate
            }
        } else if newDataArray[0].CalibrationData![0] - newDataArray[1].CalibrationData![0] < 0 {
            let Tf = max - newDataArray[0].CalibrationData![0]
            if Tf > fallenRate {
                newDataArray[0].CalibrationData![0] = max - fallenRate
            }
        }
        
        return newDataArray[0]
    }
    
    public func UpdateAlgoParam(param: GlucoseCorrectParam) {
        SDK_Setting.shared.RawData2BGBias = param.RawData2BGBias ?? 100
        SDK_Setting.shared.BGBias = param.BGBias ?? 100
        SDK_Setting.shared.BGLow = param.BGLow ?? 40
        SDK_Setting.shared.BGHigh = param.BGHigh ?? 400
        SDK_Setting.shared.MapRate = param.MapRate ?? 1
        SDK_Setting.shared.ThresholdRise = param.ThresholdRise ?? 50
        SDK_Setting.shared.ThresholdFall = param.ThresholdFall ?? 50
        SDK_Setting.shared.RiseRate = param.RiseRate ?? 100
        SDK_Setting.shared.FallenRate = param.FallenRate ?? 100
    }
    
}
