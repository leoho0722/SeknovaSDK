//
//  StartTimeConfigure.swift
//  Seknova
//
//  Created by Leo Ho on 2022/4/8.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class StartTimeConfigure: NSObject {
    
    // 紀錄設定使用時間的資料結構
    public var year: UInt16?
    public var month: UInt8?
    public var day: UInt8?
    public var hours: UInt8?
    public var minutes: UInt8?
    public var seconds: UInt8?
    public var timeZone: Int8? // 時區 GMT
    public var daySaveTime: UInt8? // 日光節約時間
    
}
