//
//  SensorInfo.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/4/6.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class SensorInfo: NSObject {
    
    public var SensorID: String?
    public var TransmitterID: String?
    public var UserID: String?
    public var SensorStartTime: Int?
    public var SensorTotalLife: Int?
    
    public func GetUsedTime() -> Int {
        if SensorStartTime == nil {
            return 0
        } else {
            return Int(Date().timeIntervalSince1970) - SensorStartTime!
        }
    }
    
}
