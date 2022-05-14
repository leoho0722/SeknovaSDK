//
//  SDK_CommandBase.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/4/18.
//  Copyright © 2022 鈞. All rights reserved.
//

import UIKit

public class SDK_CommandBase: NSObject {
    
    public static let shareInstance = SDK_CommandBase()
    
//    var textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 140, height: 40))
    // ex:  <534b0215 0000119b 00000776 001a0081 f960a051 00010001 c5>
    // FFF4:<xxxxxxxx 00000010 0000076e 00160000 00000000 00000000 xx>
    // 0719:<534b0215 00000003 00007fff 0b230000 00000067 00000000 c5>
    public var advData: AdvData?
    let judgeStr = "534b"
    public func advertiDataChange(_ index:[String]) {
        if index[0] + index[1] == judgeStr {
            advData = AdvData.init(companyID: index[0]+index[1],
                                   dataType: index[2],
                                   dataLengh: index[3],
                                   count: index[4]+index[5]+index[6]+index[7],
                                   trend: index[8]+index[9],
                                   adc: index[10]+index[11],
                                   temperature: index[12]+index[13],
                                   address: index[14]+index[15]+index[16]+index[17]+index[18]+index[19],
                                   status: index[14],
                                   rssi: index[15]+index[16]+index[17]+index[18],
                                   battery: index[19],
                                   macAddr: index[20]+index[21],
                                   rtcTime: index[22]+index[23]+index[24]+index[25],
                                   resetCount: index[26],
                                   chargeCount: index[27]+index[28])
        }
    }
    
    public var coverData: CoverData?
    public  func coverDataChange(_ index:[String]) {
        coverData = CoverData.init(startIndex: index[0]+index[1]+index[2]+index[3],
                                   totalCount: index[4]+index[5],
                                   adc: [index[6]+index[7]+index[8]+index[9],
                                         index[17]+index[18]+index[19]+index[20],
                                         index[28]+index[29]+index[30]+index[31],
                                         index[39]+index[40]+index[41]+index[42],
                                         index[50]+index[51]+index[52]+index[53],
                                         index[61]+index[62]+index[63]+index[64],
                                         index[72]+index[73]+index[74]+index[75],
                                         index[83]+index[84]+index[85]+index[86],
                                         index[94]+index[95]+index[96]+index[97],
                                         index[105]+index[106]+index[107]+index[108],],
                                   temperature: [index[10]+index[11],
                                                 index[21]+index[22],
                                                 index[32]+index[33],
                                                 index[43]+index[44],
                                                 index[54]+index[55],
                                                 index[65]+index[66],
                                                 index[76]+index[77],
                                                 index[87]+index[88],
                                                 index[98]+index[99],
                                                 index[109]+index[110],],
                                    status: [index[12],
                                             index[23],
                                             index[34],
                                             index[45],
                                             index[56],
                                             index[67],
                                             index[78],
                                             index[89],
                                             index[100],
                                             index[111],],
                                   rtcTime: [index[13]+index[14]+index[15]+index[16],
                                                 index[24]+index[25]+index[26]+index[27],
                                                 index[35]+index[36]+index[37]+index[38],
                                                 index[46]+index[47]+index[48]+index[49],
                                                 index[57]+index[58]+index[59]+index[60],
                                                 index[68]+index[69]+index[70]+index[71],
                                                 index[79]+index[80]+index[81]+index[82],
                                                 index[90]+index[91]+index[92]+index[93],
                                                 index[101]+index[102]+index[103]+index[104],
                                                 index[112]+index[113]+index[114]+index[115],])
    }
    
    public var deviceInfoData: DeviceInfoData?
    public func deviceInfoDataChange(_ index:[String]) {
        deviceInfoData = DeviceInfoData.init(size: index[0],
                                             feature: index[1]+index[2]+index[3]+index[4],
                                             type: index[5],
                                             sample_location: index[6],
                                             major: index[7],
                                             minor: index[8],
                                             debug: index[9],
                                             sleepTime: index[10]+index[11]+index[12]+index[13],
                                             preConditionTime: index[14]+index[15],
                                             advTime: index[16]+index[17],
                                             dacTime: index[18]+index[19])
    }
    
    public var deviceRtcInfoData: RtcInfoData?
    public func rtcInfoChange(_ index:[String]) {
        deviceRtcInfoData = RtcInfoData.init(dStartTime: index[0]+index[1]+index[2]+index[3],
                                         dRtcTime: index[4]+index[5]+index[6]+index[7],
                                         dRtcIndex: index[8]+index[9]+index[10]+index[11] )
    }
    
    public var measurementData: cgmMeasurementData?
    public func measurementDataChange(_ index:[String]) {
        measurementData = cgmMeasurementData.init(size: index[0],
                                          flag: index[1],
                                          glucose: index[2]+index[3],
                                          timeoffset: index[4]+index[5],
                                          status: index[6]+index[7]+index[8],
                                          trend: index[9]+index[10],
                                          quality: index[11]+index[12],
                                          e2e_crc: index[13]+index[14])
    }
    
    public var statusData: cgmStatusData?
    public func statusDataChange(_ index:[String]) {
        statusData = cgmStatusData.init(size: index[0],
                                        timeOffset: index[1]+index[2],
                                        cgmStatus: index[3]+index[4]+index[5],
                                        e2e_crc: index[6]+index[7],
                                        warmUpTime: index[8]+index[9],
                                        calibrationTime: index[10]+index[11])
    }
    
    public var sessionStartTime: sessionStartTimeData?
    public func sessionStartTimeDataChange(_ index:[String]) {
        sessionStartTime = sessionStartTimeData.init(size: index[0],
                                                     startTime: index[1]+index[2]+index[3]+index[4]+index[5]+index[6]+index[7],
                                                     timeZone: index[8],
                                                     dst: index[9],
                                                     e2e_crc: index[10]+index[11])
    }
    
    public var sessionRunTime: sessionRunTimeData?
    public func sessionRunTimeDataChange(_ index:[String]) {
        sessionRunTime = sessionRunTimeData.init(size: index[0],
                                                 runTime: index[1]+index[2],
                                                 e2e_crc: index[3]+index[4])
    }
    
    public var opsControlPoint: cgm_Specific_Ops_Control_Point_Response?
    public func opsControlPointChange(_ index:[String]) {
        opsControlPoint = cgm_Specific_Ops_Control_Point_Response.init(size: index[0],
                                                                       opCode: index[1],
                                                                       reqOPCode: index[2],
                                                                       rspCode: index[3])
    }
    
//    func changeIndicatotyLabelText(text: String) {
//        DispatchQueue.main.async {
//            self.textLabel.text = text
//        }
//    }
    
}
