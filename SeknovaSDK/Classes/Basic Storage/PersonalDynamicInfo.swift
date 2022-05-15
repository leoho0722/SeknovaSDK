//
//  PersonalDynamicInfo.swift
//  Seknova
//
//  Created by Leo Ho on 2022/3/21.
//  Copyright © 2022 鈞. All rights reserved.
//

import Foundation

public class PersonalDynamicInfo: NSObject, Codable {
    
    // 記錄使用者個人時效性的生理資料
    public var UserID: String? // 使用者 ID
    public var Timestamp: Int64? // 資料取得的時間 (時間戳)
    public var BodyFatPercentage: Int? // 體脂肪率
    public var HbA1c: Float? // 糖化血色素
    public var SYS: Int? // 收縮壓
    public var DIA: Int? // 舒張壓
    public var TC: Int? // 總膽固醇
    public var HDLC: Int? // 高密度脂蛋白膽固醇
    public var LDL: Int? // 低密度脂蛋白
    public var Diabletes: Int? // 有無糖尿病
    public var CRE: Float? // 肌酸酐
    
}
