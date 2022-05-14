//
//  EventTable.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/21.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class EventTable: NSObject, Codable {
    
    // 記錄使用者生活作息與血糖相關事件
    public var Index: Int? // 該筆事件的 ID
    public var TimeStamp: Int64? // 資料取得的時間 (時間戳)
    public var EventID: Int? // 事件 ID
    public var EventValue: Int? // 事件 Value
    public var EventAttribute: [String]? // 紀錄事件的 Attribute
    
}
