//
//  GlucoseCorrectParam.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/21.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class GlucoseCorrectParam: NSObject, Codable {
    
    // 血糖校正算法參數
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
    
}
