//
//  CustomClass.swift
//  Seknova
//
//  Created by 葉書誠 on 2022/3/28.
//  Copyright © 2022 鈞. All rights reserved.
//

import UIKit

// FFF4
public class AdvData: NSObject {
    
    public let companyID: String?
    public let dataType: String?
    public let dataLengh: String?
    public let count: String?
    public let adc: String?
    public let trend: String?
    public let temperature: String?
    public let address: String?
    public let status: String?
    public let rssi: String?
    public let battery: String?
    public let macAddr: String?
    public let rtcTime: String?
    public let resetCount: String?
    public let chargeCount: String?
    
    public init(companyID: String,
         dataType: String,
         dataLengh: String,
         count: String,
         trend: String,
         adc: String,
         temperature: String,
         address: String,
         status: String,
         rssi: String,
         battery: String,
         macAddr: String,
         rtcTime: String,
         resetCount: String,
         chargeCount: String) {
        self.companyID = companyID
        self.dataType = dataType
        self.dataLengh = dataLengh
        self.count = count
        self.adc = adc
        self.trend = trend
        self.temperature = temperature
        self.address = address
        self.status = status
        self.rssi = rssi
        self.battery = battery
        self.macAddr = macAddr
        self.rtcTime = rtcTime
        self.resetCount = resetCount
        self.chargeCount = chargeCount
    }

}

// FFF3
public class CoverData: NSObject {
    
    public let startIndex: String?
    public let totalCount: String?
    public let adc: [String]?
    public let temperature: [String]?
    public let status: [String]?
    public let rtcTime: [String]?

    public init(startIndex: String, totalCount: String, adc: [String], temperature: [String], status: [String], rtcTime: [String]) {
        self.startIndex = startIndex
        self.totalCount = totalCount
        self.adc = adc
        self.temperature = temperature
        self.status = status
        self.rtcTime = rtcTime
    }
    
}

// 2AA8
public class DeviceInfoData: NSObject {
    
    public let size: String?
    public let feature: String?
    public let type: String?
    public let sample_location: String?
    public let major: String?
    public let minor: String?
    public let debug: String?
    public let sleepTime: String?
    public let preConditionTime: String?
    public let advTime: String?
    public let dacTime: String?
    
    public init(size: String, feature: String, type: String, sample_location: String,
         major: String, minor: String, debug: String, sleepTime: String, preConditionTime: String, advTime: String, dacTime: String) {
        self.size = size
        self.feature = feature
        self.type = type
        self.sample_location = sample_location
        self.major = major
        self.minor = minor
        self.debug = debug
        self.sleepTime = sleepTime
        self.preConditionTime = preConditionTime
        self.advTime = advTime
        self.dacTime = dacTime
    }
    
}

// FFF5
public class RtcInfoData: NSObject {
    
    public let dStartTime: String?
    public let dRtcTime: String?
    public let dRtcIndex: String?
    
    public init(dStartTime: String, dRtcTime: String, dRtcIndex: String) {
        self.dStartTime = dStartTime
        self.dRtcTime = dRtcTime
        self.dRtcIndex = dRtcIndex
    }
    
}

// 2AA7
public class cgmMeasurementData: NSObject {
    
    public let size: String?
    public let flag: String?
    public let glucose: String?
    public let timeoffset: String?
    public let status: String?
    public let trend: String?
    public let quality: String?
    public let e2e_crc: String?
    
    public init(size: String, flag: String, glucose: String, timeoffset: String,
         status: String, trend: String, quality: String, e2e_crc: String) {
        self.size = size
        self.flag = flag
        self.glucose = glucose
        self.timeoffset = timeoffset
        self.status = status
        self.trend = trend
        self.quality = quality
        self.e2e_crc = e2e_crc
    }
    
}

// 2AA9
public class cgmStatusData: NSObject {
    
    public let size: String?
    public let timeOffset: String?
    public let cgmStatus: String?
    public let e2e_crc: String?
    public let warmUpTime: String?
    public let calibrationTime: String?
    
    public init(size: String, timeOffset: String, cgmStatus: String, e2e_crc: String, warmUpTime: String, calibrationTime: String){
        self.size = size
        self.timeOffset = timeOffset
        self.cgmStatus = cgmStatus
        self.e2e_crc = e2e_crc
        self.warmUpTime = warmUpTime
        self.calibrationTime = calibrationTime
    }
    
}

// 2AAA
public class sessionStartTimeData: NSObject {
    
    public let size: String?
    public let startTime: String?
    public let timeZone: String?
    public let dst: String?
    public let e2e_crc: String?
    
    public init(size: String, startTime: String, timeZone: String, dst: String, e2e_crc: String) {
        self.size = size
        self.startTime = startTime
        self.timeZone = timeZone
        self.dst = dst
        self.e2e_crc = e2e_crc
    }
    
}

// 2AAB
public class sessionRunTimeData: NSObject {
    
    public let size: String?
    public let runTime: String?
    public let e2e_crc: String?
    
    public init(size: String, runTime: String, e2e_crc: String) {
        self.size = size
        self.runTime = runTime
        self.e2e_crc = e2e_crc
    }
    
}

// 2A52
public class recordAccessControlPoint: NSObject {
    
    public let size: String?
    public let _operator: String?
    public let id: String?
    public let Records_ndx_last_to_send: String?
    public let Operand_of_the_RACP_response_to_be_sent: String?
    public let RACP_Request: String?
    public let RACP_response_to_be_sent: String?
    public let RACP_Active: String?
    public let pending_racp_response_operand: String?

    public init(size: String,
         _operator: String,
         id: String,
         Records_ndx_last_to_send: String,
         Operand_of_the_RACP_response_to_be_sent: String,
         RACP_Request: String,
         RACP_response_to_be_sent: String,
         RACP_Active: String,
         pending_racp_response_operand: String) {

        self.size = size
        self._operator = _operator
        self.id = id
        self.Records_ndx_last_to_send = Records_ndx_last_to_send
        self.Operand_of_the_RACP_response_to_be_sent = Operand_of_the_RACP_response_to_be_sent
        self.RACP_Request = RACP_Request
        self.RACP_response_to_be_sent = RACP_response_to_be_sent
        self.RACP_Active = RACP_Active
        self.pending_racp_response_operand = pending_racp_response_operand
    }
    
}




// 2CCA 校正值 寫入
public class calibrationDataWrite: NSObject {
    
    public let size: String?
    public let opCode: String?
    public let dataLen: String?
    public let calibrationData: String?

    public init(size: String, opCode: String, dataLen: String, calibrationData: String) {
        self.size = size
        self.opCode = opCode
        self.dataLen = dataLen
        self.calibrationData = calibrationData
    }
    
}

// 2CCA sensorID 寫入
public class sensorIdWriteData: NSObject {
    
    public let size: String?
    public let opCode: String?
    public let dataLen: String?
    public let sensorID: String?

    public init(size: String, opCode: String, dataLen: String, sensorID: String) {
        self.size = size
        self.opCode = opCode
        self.dataLen = dataLen
        self.sensorID = sensorID
    }
    
}


// 2CCA response
public class cgm_Specific_Ops_Control_Point_Response: NSObject {
    
    public let size: String?
    public let opCode: String?
    public let reqOPCode: String?
    public let rspCode: String?

    public init(size: String, opCode: String, reqOPCode: String, rspCode: String) {
        self.size = size
        self.opCode = opCode
        self.reqOPCode = reqOPCode
        self.rspCode = rspCode
    }
    
}
