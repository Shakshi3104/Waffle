//
//  DeviceInformation.swift
//  Waffle
//
//  Created by Mac mini M2 Pro on 2023/09/21.
//

#if os(iOS)
import UIKit
#endif

import Foundation
import SwiftUI

import CoreWafer
import DeviceHardware


class DeviceInfo {
    public static let shared = DeviceInfo()
    
    /// - Tag: system information
    let device: String
    let os: String
    let processor: String
    let cpu: String
    let efficiencyCore: Int
    let performanceCore: Int
    let gpu: String
    let neuralEngine: String
    
    let cpuCount: Int
    let ram: Int
    let ramString: String
    
    let modelIdentifier: String
    
    let hasDynamicIsland: Bool?

    /// - Tag: core type style
    let coreTypeStyle: CoreTypeStyle

    init() {
        let coreType = CoreTypeInformation()
        
        // macOS or Catalystの場合
        #if os(macOS) || targetEnvironment(macCatalyst)
        device = MacDeviceHardware.deviceHardware.modelName
        let osVersion = ProcessInfo.processInfo.operatingSystemVersion
        // patchVersion == 0のときは、patchVersionを表示しない
        os = "macOS \(osVersion.majorVersion).\(osVersion.minorVersion)" + (osVersion.patchVersion == 0 ? "" :  ".\(osVersion.patchVersion)")
        processor = MacDeviceHardware.deviceHardware.processorName
        cpu = MacDeviceHardware.deviceHardware.cpu
        gpu = MacDeviceHardware.deviceHardware.gpu
        neuralEngine = MacDeviceHardware.deviceHardware.neuralEngine
        
        cpuCount = MacDeviceHardware.deviceHardware.processorCount
        ram = MacDeviceHardware.deviceHardware.ram
        ramString = MacDeviceHardware.deviceHardware.ramString
        modelIdentifier = MacDeviceHardware.deviceHardware.modelIdentifier
        
        efficiencyCore = coreType.efficiencyCoreCount
        performanceCore = coreType.performanceCoreCount
        
        hasDynamicIsland = nil
        // iOSの場合
        #elseif os(iOS)
        device = UIDeviceHardware.deviceHardware.modelName
        os = UIDevice.current.systemName + " " + UIDevice.current.systemVersion
        processor = UIDeviceHardware.deviceHardware.processorName
        cpu = UIDeviceHardware.deviceHardware.cpu
        gpu = UIDeviceHardware.deviceHardware.gpu
        neuralEngine = UIDeviceHardware.deviceHardware.neuralEngine
        
        cpuCount = UIDeviceHardware.deviceHardware.processorCount
        ram = UIDeviceHardware.deviceHardware.ram
        ramString = UIDeviceHardware.deviceHardware.ramString
        modelIdentifier = UIDeviceHardware.deviceHardware.modelIdentifier
        
        efficiencyCore = coreType.efficiencyCoreCount
        performanceCore = coreType.performanceCoreCount
        
        hasDynamicIsland = UIDeviceHardware.deviceHardware.hasDynamicIsland
        #endif

        coreTypeStyle = CoreTypeStyle(processorName: processor)
    }
}

/// CPUコアの呼び方と色
/// M5・A20 Pro以降は旧Performanceコアを「Super」と呼び、M5 Pro/MaxはEfficiencyコアの代わりに新しい「Performance」コアを持つ
struct CoreTypeStyle {
    /// 下位コア (hw.perflevel1) の呼び方
    let lowerLabel: String
    /// 上位コア (hw.perflevel0) の呼び方
    let upperLabel: String
    /// 下位コアの色
    let lowerColor: Color
    /// 上位コアの色
    let upperColor: Color
    
    init(processorName: String) {
        // "Apple A20 Pro", "Apple M5 Max" などから系列・世代・グレードを取り出す
        guard let match = processorName.firstMatch(of: /Apple ([AM])(\d+)(?: (Pro|Max|Ultra))?/),
              let generation = Int(match.2) else {
            lowerLabel = "Efficiency"
            upperLabel = "Performance"
            lowerColor = .peacockGreen
            upperColor = .iris
            return
        }
        
        let isMSeries = match.1 == "M"
        let hasSuperCores = isMSeries ? generation >= 5 : generation >= 20
        let hasNewPerformanceCores = isMSeries && generation >= 5 && match.3 != nil
        
        lowerLabel = hasNewPerformanceCores ? "Performance" : "Efficiency"
        upperLabel = hasSuperCores ? "Super" : "Performance"
        lowerColor = hasNewPerformanceCores ? .iris : .peacockGreen
        upperColor = hasSuperCores ? .marigold : .iris
    }
}
