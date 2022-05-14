//
//  AlertTable.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/21.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class AlertTable: NSObject, Codable {
    
    // 記錄警示事件
    public var Timestamp: Int64? // 資料取得的時間 (時間戳)
    public var AlertID: Int? // 警示事件 ID，對應到 ErrorCode
    public var AlertValue: Int? // 警示事件 Value，對應到 ErrorValue
    
}
