//
//  SensingRecord.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/3/25.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class SensingRecord: NSObject, Codable {
    
    public var Timestamp: Int64?
    public var IndexID: Int?
    public var RawData: [Int]?
    public var CalibrationData: [Int]?
    public var Temperature: Int?
    public var Trend: Int?
    public var RSSI: Int?
    public var Battery: Int?
    public var SensorID: String?
    public var UserID: String?
    public var isDisplay: Bool?
    
}
